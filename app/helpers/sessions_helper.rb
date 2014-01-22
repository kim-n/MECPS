module SessionsHelper
  def current_user
    User.find_by_session_token(session[:token])
  end
  
  def log_in(user)
    session[:token] = user.session_token
  end
  
  def log_out_current_user!
    current_user.reset_session_token!
    session.delete(:token)
  end
  
  def require_current_user
    redirect_to new_session_url unless current_user
  end
  
  def require_no_current_user
    redirect_to user_url(current_user) if current_user
  end
end
