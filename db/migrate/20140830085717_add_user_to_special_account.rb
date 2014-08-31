class AddUserToSpecialAccount < ActiveRecord::Migration
  def change
    add_reference :special_accounts, :user, index: true
  end
end
