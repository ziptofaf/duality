class AddServerPoolToAccounts < ActiveRecord::Migration
  def change
    add_reference :accounts, :server_pool, index: true
  end
end
