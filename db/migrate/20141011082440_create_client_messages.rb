class CreateClientMessages < ActiveRecord::Migration
  def change
    create_table :client_messages do |t|
      t.string :text
      t.string :url

      t.timestamps
    end
  end
end
