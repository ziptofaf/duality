class RemoveCapacityMaxFromServers < ActiveRecord::Migration
  def change
    remove_column :servers, :capacity_max, :integer
  end
end
