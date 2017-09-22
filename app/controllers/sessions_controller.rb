class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if user.authority.eql? 'super'
        log_in user, :super
        redirect_to root_path
      elsif user.authority.eql? 'user'
        log_in user, :user
        redirect_to root_path
      elsif user.authority.eql? 'customer'
        log_in user, :customer
        redirect_to root_path
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
