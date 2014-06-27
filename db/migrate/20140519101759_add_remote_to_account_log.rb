class AddRemoteToAccountLog < ActiveRecord::Migration
  def change
    add_column :account_logs, :remote, :string
  end
end
