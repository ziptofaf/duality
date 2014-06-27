class AddProductIdToAccount < ActiveRecord::Migration
  def change
    add_reference :accounts, :product, index: true
  end
end
