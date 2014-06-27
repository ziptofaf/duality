module SessionsHelper
def sign_in(user)
 session[:user_id]= user.id
 session[:expires_at] = 30.minutes.from_now.to_s
end

def logged_in?
  if session[:user_id] && session_time_left
   update_session_time
   return true
  else
   sign_out if session[:user_id]
   return false
  end 
end 

def update_session_time
session[:expires_at]=30.minutes.from_now.to_s
end

def session_time_left
return false if session[:expires_at].to_datetime < Time.now 
return true
end

def sign_out
flash.now[:session]="Your session has expired, please log in again"
session.clear
end

def balance
 if logged_in?
  user = User.find(session[:user_id])
  balance = user.balance
 else
 end
end
def error_message
flash[:error]="Something went wrong, please try again later"
end 
end

