class SuperadminsController < ApplicationController
  before_action :set_superadmin, only: [:show, :edit, :update, :destroy]
  before_action :has_authority?

  # GET /superadmins
  # GET /superadmins.json
  def index
    @superadmins = User.where(:authority => 'super')
  end

  # GET /superadmins/1
  # GET /superadmins/1.json
  def show

  end

  # GET /superadmins/new
  def new
    @superadmin = User.new
  end

  # GET /superadmins/1/edit
  def edit

  end

  # POST /superadmins
  # POST /superadmins.json
  def create
    @superadmin = User.new(superadmin_params)
    @superadmin.authority = 'super'
    respond_to do |format|
      if @superadmin.save
        format.html {redirect_to superadmin_path(@superadmin), notice: 'Superadmin was successfully created.'}
        format.json {render :show, status: :created, location: @superadmin}
      else
        format.html {render :new}
        format.json {render json: @superadmin.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /superadmins/1
  # PATCH/PUT /superadmins/1.json
  def update
    respond_to do |format|
      if @superadmin.update(superadmin_params)
        format.html {redirect_to superadmin_path(@superadmin), notice: 'Superadmin was successfully updated.'}
        format.json {render :show, status: :ok, location: @superadmin}
      else
        format.html {render :edit}
        format.json {render json: @superadmin.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /superadmins/1
  # DELETE /superadmins/1.json
  def destroy
    @superadmin.destroy
    respond_to do |format|
      format.html {redirect_to superadmins_url, notice: 'Superadmin was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_superadmin
    @superadmin = User.find(params[:id])
  end

  def has_authority?
    auth = login_authority
    if !auth || auth != 'super'
      redirect_to login_path, notice: 'You are not authorized to do that !!!'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def superadmin_params
    params.require(:superadmin).permit(:email, :name, :password, :password_confirmation)
  end
end
