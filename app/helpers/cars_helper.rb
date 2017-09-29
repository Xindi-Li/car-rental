module CarsHelper
  require 'rufus-scheduler'

  def schedule
    scheduler = Rufus::Scheduler.new
    scheduler.every '2s' do
      Rails.logger.info "hello, it's #{Time.now}"
    end
  end
end
