class ProductProcessor < ActiveRecord::Base
has_many :products
validates :name, uniqueness: { case_sensitive: false }
end
