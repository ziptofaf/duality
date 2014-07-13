require 'securerandom'
module VpnHelper
  def find_a_server(location, level=1)
   server = (Server.where('location = ? AND level = ?', location,level)).order(:capacity_current).limit(1) 
   raise 'Invalid location' if server.size==0
    server.each do |s1|
     return s1
    end
  end
  
  def pay(amount)
   error_message and raise 'THIS MUST BE POSITIVE' unless amount>0 
   flash[:error]="Insufficient funds" and raise 'Insufficient funds' if balance-amount<0
   user = User.find(session[:user_id])
   funds = user.balance - amount
   user.update_attribute :balance, funds
  end
 
 def check_if_correct(time)
  error_message and raise 'Invalid contract time' unless time==3 or time==2 or time==1 or time==0.5
 end 

 def can_extend?(id)
  error_message and raise 'Invalid_id' unless Account.exists?(id: id, user_id: session[:user_id])
  account = Account.find(id)
  error_message and raise 'Trying to access foreign account' unless session[:user_id]==account.user_id
  flash[:error]="This offer is discontinued and cannot be extended" and raise 'Product no longer exists!' unless Product.exists?(id: account.product_id)
  product = Product.find(account.product_id)
  return product
 end
 
 def extend_this_account(id, length)
  error_message and raise 'Invalid_id' unless Account.exists?(id: id)
  account = Account.find(id)
  expire = account.expire
  new_date = expire + length.to_i.months if length>0.5
  new_date = expire + 2.weeks if length==0.5
  account.update_attribute :expire, new_date
 end

 def create_account(server, product_id, expire_value)
  account=Account.new
  account.login = random_hash
  account.password = random_hash
  account.server_id = server.id
  account.user_id = session[:user_id]
  account.level = server.level
  account.product_id = product_id
  account.active = 0
  if expire_value==0.5
    account.expire = 2.weeks.from_now 
  else
    account.expire = expire_value.to_i.months.from_now
  end
  error_message and raise 'couldnt save the record' unless account.save
 end

 def log_payment(product_id, value, extending=false)
  purchase = Purchase.new
  purchase.date = Time.now
  purchase.user_id=session[:user_id]
  purchase.value=value
  error_message and raise 'INVALID PRODUCT ID' unless Product.exists?(id: product_id)
  product = Product.find(product_id)
  purchase.name=product.name #this means that even if i delete the product, log is saved under proper name
  purchase.name = product.name + " - extending" if extending==true
  error_message and raise 'couldnt save the log record' unless purchase.save
 end
 
 def random_hash
  random_string = SecureRandom.base64(30)
  random_string.split(/[+,=\/]/).join
 end

 def parameters_to_level (parameter)
	return 1 if parameter=='basic'
	return 2 if parameter=='medium'
	return 3 if parameter=='advanced'
	return 4 if parameter=='extreme'
	raise 'wrong parameters!' and return 0
 end

end

