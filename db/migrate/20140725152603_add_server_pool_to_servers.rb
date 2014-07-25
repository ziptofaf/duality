class AddServerPoolToServers < ActiveRecord::Migration
  def change
    add_reference :servers, :server_pool, index: true
  end
end
