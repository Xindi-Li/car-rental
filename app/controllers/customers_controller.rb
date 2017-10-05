class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :has_authority?,except: [:new,:show, :create, :edit, :history, :reservation, :cancel]

  # GET /customers
  # GET /customers.json
  def index
    @customers = User.where(:authority => 'customer')
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = User.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = User.new(customer_params)
    @customer.authority = 'customer'
    respond_to do |format|
      if @customer.save
        if !current_user
          log_in @customer, :customer
        end
        format.html {redirect_to customer_path(@customer), notice: 'Customer was successfully created.'}
        format.json {render :show, status: :created, location: @customer}
      else
        format.html {render :new}
        format.json {render json: @customer.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html {redirect_to customer_path(@customer), notice: 'Customer was successfully updated.'}
        format.json {render :show, status: :ok, location: @customer}
      else
        format.html {render :edit}
        format.json {render json: @customer.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    email = @customer.email
    reservation = Reservation.where(email: email).where(status: "Checkout")
    if reservation != []
      respond_to do |format|
        format.html {redirect_to customers_url, notice: "Can't delete this customer as he/she still has a car checked out!"}
        return
      end
    else
      reservations = Reservation.where(email: email)
      reservations.each do |r|
        car_lpn = r.lpn
        car = Car.find_by_lpn(car_lpn)
        car.update_attribute(:status , "Available")
        r.destroy
      end
      @customer.destroy
      respond_to do |format|
        format.html {redirect_to customers_url, notice: 'Customer was successfully destroyed.'}
        format.json {head :no_content}
      end
    end
  end


  def reservation
    email = params[:customer][:email]
    @reservations = Reservation.where(email: email)
  end

  def history
    email = params[:customer][:email]
    @reservations = Reservation.where(email: email)
  end

  def cancel
    lpn = params[:reservation][:lpn]
    reservation = Reservation.where(lpn: lpn).where(status: "Reserved").first
    car = Car.find_by_lpn(lpn)
    car.update_attribute(:status , "Available")
    reservation.destroy
    # reservation.update_attributes(:status => "Canceled")

    respond_to do |format|
      format.html {redirect_to cars_url, notice: 'Reservation has been canceled.'}
    end
  end



  private
  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = User.find(params[:id])
  end

  def has_authority?
    auth = login_authority
    if !auth || auth == 'customer'
      redirect_to login_path, notice: 'You are not authorized to do that !!!'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def customer_params
    params.require(:customer).permit(:email, :name, :password, :password_confirmation)
  end
end
