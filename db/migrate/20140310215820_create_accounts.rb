class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :login
      t.string :password
      t.integer :level
      t.datetime :expire
      t.belongs_to :user, index: true
      t.belongs_to :server, index: true

      t.timestamps
    end
  end
end
