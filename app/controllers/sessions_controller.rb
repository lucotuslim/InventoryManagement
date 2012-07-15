class SessionsController < ApplicationController

 def check_session_alive

  get_session_time_left
  if @session_time_left > 0
    render 'sessions/check_session_alive', :layout=>false
  else
    sign_out
    deny_access 'Your session has timed out. Please log back in.'
  end
 end

  def new
  end
   
  def create 
    user=User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
     sign_in user
     redirect_back_or user
    else
    flash.now[:error]='Invalid email or password combination' 
    render 'new'
    end
  end

  def destroy 
   sign_out 
   redirect_to root_path
  end
end
