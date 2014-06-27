class CreateAccountLogs < ActiveRecord::Migration
  def change
    create_table :account_logs do |t|
      t.belongs_to :account, index: true
      t.integer :bytes_sent
      t.integer :bytes_received
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
