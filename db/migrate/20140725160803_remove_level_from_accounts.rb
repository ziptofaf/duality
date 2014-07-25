class RemoveLevelFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :level, :string
  end
end
