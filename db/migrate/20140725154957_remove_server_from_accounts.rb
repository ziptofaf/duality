class RemoveServerFromAccounts < ActiveRecord::Migration
  def change
    remove_reference :accounts, :server, index: true
  end
end
