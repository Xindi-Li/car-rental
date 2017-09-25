class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :has_authority?,except: [:new,:show, :history, :reservation]

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
        format.html {redirect_to customers_path, notice: 'Customer was successfully created.'}
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
        format.html {redirect_to @customer, notice: 'Customer was successfully updated.'}
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
    @customer.destroy
    respond_to do |format|
      format.html {redirect_to customers_url, notice: 'Customer was successfully destroyed.'}
      format.json {head :no_content}
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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = User.find(params[:id])
  end

  def has_authority?
    auth = login_authority
    if !auth || auth == 'customer'
      redirect_to login_path
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def customer_params
    params.require(:customer).permit(:email, :name, :password, :password_confirmation)
  end
end
