class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :ip
      t.string :location
      t.integer :capacity_max
      t.integer :capacity_current
      t.string :cert_url

      t.timestamps
    end
  end
end
