class AddBalanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :balance, :decimal, precision: 7, scale: 2
  end
end
