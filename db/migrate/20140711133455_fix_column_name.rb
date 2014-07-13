class FixColumnName < ActiveRecord::Migration
  def change
	rename_column :account_logs, :bytes_sent, :kilobytes_sent
	rename_column :account_logs, :bytes_received, :kilobytes_received
  end
end
