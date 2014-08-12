class ChangeDetailsToTextInProducts < ActiveRecord::Migration
  def change
   change_table :products do |t|
        t.change :details, :text
     end   
  end
end
