class AddFieldCertNameToServer < ActiveRecord::Migration
  def change
    add_column :servers, :certname, :string
  end
end
