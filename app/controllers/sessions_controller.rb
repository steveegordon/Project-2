class SessionsController < ApplicationController
  # method for login page
  def new
  end
# create session method, looks for user based on email and uses authenticate to verify password matches user
# if so creates new session and redirects to user page
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      #  page re-renders and shows one time message stating password and email do not match
      flash.now[:danger] = "Invalid e-mail and/or password"
      render 'new'
    end
  end
  # destroy method calls log_out function which sets session to nil and logs out user
  # redirects to homepage
  def destroy
    log_out
    redirect_to root_url
  end

end
