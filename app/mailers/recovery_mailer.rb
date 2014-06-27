class RecoveryMailer < ActionMailer::Base
require 'securerandom'
  default from: "noreply@dualitynetwork.com"
  
  def send_password_code(_email)
   @email = _email
   @code = SecureRandom.hex(30)
   @code = SecureRandom.hex(29) if (Recovery.exists?(:code => @code))
   expire = 6.hours.from_now
   recovery = Recovery.new
   return unless User.exists?(email: _email)
   user = User.find_by email: _email
   recovery.user = user
   recovery.expire = expire
   recovery.code = @code
   recovery.save  
   mail(to: @email, subject: 'Duality Network password recovery') 
  end
  
  def send_password(_email, _password)
  @email = _email
  @password = _password
  mail(to: @email, subject: 'Your new password')
  end
end
