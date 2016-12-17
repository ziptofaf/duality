class CreateProductProcessors < ActiveRecord::Migration
  def change
    create_table :product_processors do |t|
      t.string :name
      t.integer :usable

      t.timestamps
    end
  end
end
