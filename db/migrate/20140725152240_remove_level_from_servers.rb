class RemoveLevelFromServers < ActiveRecord::Migration
  def change
    remove_column :servers, :level, :string
  end
end
