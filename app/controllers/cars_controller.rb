class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  # GET /cars
  # GET /cars.json
  def index
    if params[:car].nil?
      return @cars = Car.all
    end
    param = car_params.to_h.delete_if {|key, value| value==""}
    if param.size==0
      @cars = Car.all
    else
      @cars = Car.where(param)
    end
  end

  def edit_reserve
    id = params[:id]
    @reservation = Reservation.find(id)
  end

  def update_reserve
    customer_email = params[:reservation][:email]
    car_lpn = params[:reservation][:lpn]
    @reservation = Reservation.where(email: customer_email).where(lpn: car_lpn).where(status: "Reserved").first
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html {redirect_to reservations_path, notice: 'Reservation was successfully updated.'}
      else
        format.html {redirect_to edit_path(:id => @reservation.id), notice: @reservation.errors.full_messages[0]}

      end
    end
  end

  def index_reserve
    @reservations = Reservation.all
  end


  def new_reserve
    email = params[:reserve][:email]
    @reservation1 = Reservation.where(email: email).where(status: "Checkout")
    @reservation2 = Reservation.where(email: email).where(status: "Reserved")
    if @reservation1 != [] || @reservation2 != []
      respond_to do |format|
        format.html {redirect_to cars_url, notice: "You can't reserve more than one car at the same time."}
      end
    else
      lpn = params[:reserve][:lpn]
      @reservation = Reservation.new(:lpn => lpn)
    end
  end

  def create_reserve
    expect_start_time = params[:expect_start_time]
    expect_return_time = params[:expect_return_time]
    current_time = Time.now

    @reservation = Reservation.create(reservation_params)

    respond_to do |format|
      user = User.find_by_email(@reservation.email)
      if !user
        format.html {redirect_to reserve_path(:lpn => @reservation.lpn), notice: 'Customer does not exist'}
      end
      if @reservation.save
        checkout_timer @reservation.expect_start_time, @reservation.id, @reservation.lpn
        @car = Car.find_by_lpn(@reservation.lpn)
        if @car.status == "Available"
          @car.status = "Reserved"
          @car.update_attributes(:status => "Reserved")
        end
        @reservation.update_attributes(:status => "Reserved")
        format.html {redirect_to @car, notice: 'Reservation was successfully made.'}
        #   format.json { render :show_reserve, status: :reserved, location: @reservation }
      else
        format.html {render :new_reserve}
      end
    end
  end

  def show_reserve
  end

  def history
    lpn = params[:car][:carlpn]
    @reservations = Reservation.where(lpn: lpn)
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)
    @car.status = "Available"
    respond_to do |format|
      if @car.save
        format.html {redirect_to @car, notice: 'Car was successfully created.'}
        format.json {render :show, status: :created, location: @car}
      else
        format.html {render :new}
        format.json {render json: @car.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html {redirect_to @car, notice: 'Car was successfully updated.'}
        format.json {render :show, status: :ok, location: @car}
      else
        format.html {render :edit}
        format.json {render json: @car.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    # @car.destroy
    car_lpn = @car.lpn
    reservation = Reservation.where(lpn: car_lpn).where(status: "Checkout")
    if reservation != []
      respond_to do |format|
        format.html {redirect_to cars_url, notice: "Can't delete a car currently checked out!"}
      end
    else
      reservation = Reservation.where(lpn: car_lpn)
      reservation.each do |r|
        r.destroy
      end
      @car.destroy
      respond_to do |format|
        format.html {redirect_to cars_url, notice: 'Car was successfully destroyed.'}
        format.json {head :no_content}
      end
    end
  end

  def reserve lpn
    @lpn = lpn
    @car = Car.find_by_lpn(:lpn)
    if @car.status == "available"
      @car.status = "reserved"
      true
    else
      false
    end
  end

  def checkout
    lpn = params[:reservation][:lpn]
    @reservation = Reservation.where(:lpn => lpn).where(:status => "Reserved").first
    current_time = Time.now
    if current_time < @reservation.expect_start_time
      respond_to do |format|
        format.html {redirect_to customer_reservation_path(:customer => {:email => @reservation.email}), notice: "Can't checkout a car before your checkout time."}
      end
    else
      return_timer @reservation.expect_return_time,@reservation.id,@reservation.lpn

      @reservation.update_attributes(:checkout_time => current_time)
      @reservation.update_attributes(:status => "Checkout")

      @car = Car.find_by_lpn(lpn)
      @car.update_attributes(:status => "Checkout")
      @car
    end
  end

  def return_car
    lpn = params[:reservation][:lpn]
    @reservation = Reservation.where(:lpn => lpn).where(:status => "Checkout").first
    current_time = Time.now
    @reservation.update_attributes(:return_time => current_time)
    @reservation.update_attributes(:status => "Returned")

    @car = Car.find_by_lpn(lpn)
    # if @car.status == "Checkout"
    @car.update_attributes(:status => "Available")
    car_hrr = @car.hrr
    rental_time = (@reservation.return_time - @reservation.checkout_time)/3600
    @reservation.update_attributes(:charge => (car_hrr*rental_time).round(2))
    user_email = @reservation.email
    user = User.find_by_email(user_email)
    if user.rental_charge == nil
      rental_charge = 0
    else
      rental_charge = user.rental_charge
    end

    rental_charge += car_hrr*rental_time
    user.update_attributes(:rental_charge => rental_charge.round(2))

    respond_to do |format|
      format.html {redirect_to @car, notice: 'Car was successfully returned.'}
    end
    # end


  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_car
    @car = Car.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def car_params
    params.require(:car).permit(:lpn, :manufactuere, :model, :hrr, :style, :location, :status, :img_attach)
  end

  def reservation_params
    params.require(:reservation).permit(:lpn, :email, :expect_start_time, :expect_return_time, :status)
  end
end
