class Product < ActiveRecord::Base
  belongs_to :ProductProcessor

validates :name, presence: true
validates :description, presence: true
validates :price, presence: true
validates :ProductProcessor, presence:true
validates :parameters, presence:true
end
