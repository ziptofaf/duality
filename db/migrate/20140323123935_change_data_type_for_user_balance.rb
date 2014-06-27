class ChangeDataTypeForUserBalance < ActiveRecord::Migration
  def change
   change_table :users do |t|
    t.change :balance, :decimal, :precision => 8, :scale => 2
   end
  end
end
