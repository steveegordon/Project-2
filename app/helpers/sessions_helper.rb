module SessionsHelper
  # creates a session belonging to user inputs id
  def log_in(user)
    session[:user_id] = user.id
  end
# checks the current user or sets the current user to the user who belongs to the session
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
# checks if session has a user value(logged in user!)
  def logged_in?
    !current_user.nil?
  end
# ends the session and resets current_user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
