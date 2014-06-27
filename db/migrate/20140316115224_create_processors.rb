class CreateProcessors < ActiveRecord::Migration
  def change
    create_table :processors do |t|
      t.string :name
      t.integer :usable

      t.timestamps
    end
  end
end
