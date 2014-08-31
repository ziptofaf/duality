include SpecialAccountHelper
module MobileHelper
  def userHasAccount?(id)
    return Account.exists?(:user_id => id)
  end
end

  def userHasMobileAccount?(id)
    return SpecialAccount.exists?(:user_id => id)
  end

  def generateMobileAccount(user_id, account_id, device = "mobile phone")
      return false if userHasMobileAccount?(user_id) #there can be only one
      return false unless Account.exists?(:user_id => user_id, :id => account_id)
      subaccount = SpecialAccount.new
      subaccount.login = uniqueLogin
      subaccount.password = uniquePassword
      subaccount.user_id = user_id
      subaccount.account_id = account_id
      subaccount.device = device
      return subaccount.save
  end

  #this one doesn't check if the account actually exists, make sure to call userHasMobileAccount first!
  def findMobileAccount(id)
      return SpecialAccount.find_by user_id: id 
  end

  def migrateMobileAccount(user_id, new_account_id)
    return false unless userHasMobileAccount?(user_id) #make sure this subaccount exists
    subaccount = SpecialAccount.where("user_id=?", user_id).first # find it
    previousAccount = Account.find(subaccount.account_id) #find previous account this subaccount was connected to
    return false unless Account.exists?(new_account_id) #make sure that the account we migrate to actually exists!
    newAccount = Account.find(new_account_id)
    return false unless previousAccount.user_id == newAccount.user_id #ensure that the main account you migrate this one to belongs to the same user!
    return true if previousAccount.id == newAccount.id #technically this is true if both accounts are the same, there's no point in saving it in the db again since no changes tho
    #if these match, you can proceed to replace and save this data
    subaccount.account_id = new_account_id
    return subaccount.save
  end
