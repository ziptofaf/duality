class CreateSpecialAccounts < ActiveRecord::Migration
  def change
    create_table :special_accounts do |t|
      t.string :login
      t.string :password
      t.belongs_to :account, index: true

      t.timestamps
    end
  end
end
