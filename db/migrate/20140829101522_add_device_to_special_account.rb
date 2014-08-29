class AddDeviceToSpecialAccount < ActiveRecord::Migration
  def change
    add_column :special_accounts, :device, :string
  end
end
