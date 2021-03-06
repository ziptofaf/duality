require 'securerandom'
module SpecialAccountHelper

def uniqueLogin
    login = "@"
    random_string = SecureRandom.base64(7)
    random_string = random_string.gsub(/[+,=\/]/, "")
    login+=random_string
end

def uniquePassword
  random_string = SecureRandom.base64(7)
  random_string = random_string.gsub(/[+,=\/]/, "")
end

def findParentAccount(a_login)
  return nil unless SpecialAccount.exists?(:login => a_login)
  subaccount = SpecialAccount.find_by login: a_login
  account = subaccount.account
  return account
end

def authorizeSubaccount(a_login, a_password)
return false unless SpecialAccount.exists?(:login => a_login)
subaccount = SpecialAccount.find_by login: a_login
return a_password==subaccount.password
end

end
