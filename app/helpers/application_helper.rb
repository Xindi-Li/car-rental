module ApplicationHelper
    def current_user
	    if session[:user_id].nil?
	      return nil
	    end
	    @current_user ||= User.find_by(id: session[:user_id]['id'])
    end
end
