class CreateRecoveries < ActiveRecord::Migration
  def change
    create_table :recoveries do |t|
      t.belongs_to :user, index: true
      t.datetime :expire
      t.string :code

      t.timestamps
    end
  end
end
