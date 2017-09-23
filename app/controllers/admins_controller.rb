class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]
  before_action :has_authority?

  # GET /admins
  # GET /admins.json
  def index
    @admins = User.where(:authority => 'admin')
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin = User.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = User.new(admin_params)
    @admin.authority = 'admin'
    respond_to do |format|
      if @admin.save
        format.html {redirect_to admin_path(@admin), notice: 'Admin was successfully created.'}
        format.json {render :show, status: :created, location: @admin}
      else
        format.html {render :new}
        format.json {render json: @admin.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html {redirect_to admin_path(@admin), notice: 'Admin was successfully updated.'}
        format.json {render :show, status: :ok, location: @admin}
      else
        format.html {render :edit}
        format.json {render json: @admin.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html {redirect_to admins_url, notice: 'Admin was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin
    @admin = User.find(params[:id])
  end

  def has_authority?
    auth = login_authority
    if !auth || auth == 'customer'
      redirect_to login_path, notice: 'You are not authorized to do that !!!'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_params
    params.require(:admin).permit(:email, :name, :password, :password_confirmation)
  end
end
