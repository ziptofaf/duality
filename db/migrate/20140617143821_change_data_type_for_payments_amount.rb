class ChangeDataTypeForPaymentsAmount < ActiveRecord::Migration
  def change
	change_table :payments do |t|
	t.change :amount, :decimal, :precision => 8, :scale => 2
        end
  end
end
