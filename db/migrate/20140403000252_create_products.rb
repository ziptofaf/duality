class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.belongs_to :ProductProcessor, index: true
      t.decimal :price,  :precision => 8, :scale => 2
      t.string :parameters

      t.timestamps
    end
  end
end
