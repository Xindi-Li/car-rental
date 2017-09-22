module SessionsHelper

  def log_in(user, authority)
    session[:user_id] = {:id => user.id, :authority => authority}
  end

  def current_user
    if session[:user_id].nil?
      return nil
    end
    @current_user ||= User.find_by(id: session[:user_id]['id'])
  end

  def login_authority
    if !current_user.nil?
      session[:user_id]['authority']
    else
      false
    end

  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
