class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :name
      t.datetime :date
      t.decimal :value, precision: 7, scale: 2

      t.timestamps
    end
  end
end
