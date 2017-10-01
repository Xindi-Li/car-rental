module CarsHelper
  require 'rufus-scheduler'

  def checkout_timer time, id, lpn
    scheduler = Rufus::Scheduler.new
    time_to_do = time + 1.minute
    Rails.logger.info "time_to_do: #{time_to_do}, id: #{id}"
    scheduler.at time_to_do do
      Rails.logger.info "hello, it's #{Time.now}"
      reservation = Reservation.find(id)
      if reservation&&reservation.status == 'Reserved'
        reservation.destroy
        Car.where(:lpn => lpn).update_all(:status => "Available")
        notification = Notification.new(:email => reservation.email, :message => 'You do not check out the car on time !')
        notification.save
      end
    end
  end

  def return_timer time, id, lpn
    scheduler = Rufus::Scheduler.new
    time_to_do = time
    Rails.logger.info "time_to_do: #{time_to_do}, id: #{id}"
    scheduler.at time_to_do do
      Rails.logger.info "hello, it's #{Time.now}"
      reservation = Reservation.find(id)
      if reservation&&reservation.status == 'Checkout'
        reservation.update_attributes(:return_time => Time.now)
        reservation.update_attributes(:status => "Returned")
        car = Car.where(:lpn => lpn)
        car.update_attributes(:status => "Available")
        car_hrr = car.hrr
        rental_time = (reservation.return_time - reservation.checkout_time)/3600
        reservation.update_attributes(:charge => (car_hrr*rental_time).round(2))

        notification = Notification.new(:email => reservation.email, :message => 'You do not return the car on time !')
        notification.save
      end
    end
  end

  def get_notification email
    notification = Notification.find_by_email(email)
    if notification
      message = notification.message
      notification.destroy
      flash[:warning] = message
    end
  end
end
