class CreateServerPools < ActiveRecord::Migration
  def change
    create_table :server_pools do |t|
      t.string :name

      t.timestamps
    end
  end
end
