class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.belongs_to :processor, index: true
      t.belongs_to :user, index: true
      t.decimal :amount
      t.string :status
      t.string :tx

      t.timestamps
    end
  end
end
