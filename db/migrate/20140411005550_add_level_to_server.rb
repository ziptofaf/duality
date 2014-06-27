class AddLevelToServer < ActiveRecord::Migration
  def change
    add_column :servers, :level, :integer
  end
end
