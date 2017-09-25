class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.all
  end

  def new_reserve
    # @car = 
    lpn = params[:lpn]
    @reservation = Reservation.new(:lpn => lpn)
  end

  def create_reserve
    expect_start_time = params[:expect_start_time]
    expect_return_time = params[:expect_return_time]
    current_time = Time.now

    @reservation = Reservation.create(reservation_params)
    

    respond_to do |format|
      if @reservation.save
        @car = Car.find_by_lpn(@reservation.lpn)
        if @car.status == "Available"
          @car.status = "Reserved"
          @car.update_attributes(:status => "Reserved")
        end
        @reservation.update_attributes(:status => "Reserved")
        format.html { redirect_to @car, notice: 'Reservation was successfully made.' }
      #   format.json { render :show_reserve, status: :reserved, location: @reservation }
      else
        format.html { render :new_reserve }
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

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
       format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
       format.json { head :no_content }
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
    @reservation.update_attributes(:checkout_time => current_time)
    @reservation.update_attributes(:status => "Checkout")

    @car = Car.find_by_lpn(lpn)
    @car.update_attributes(:status => "Checkout")
    @car
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
    respond_to do |format|
      format.html { redirect_to @car, notice: 'Car was successfully returned.' }
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
      params.require(:reservation).permit(:lpn, :email, :expect_start_time, :expect_return_time)
    end
end
