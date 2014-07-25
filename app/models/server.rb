class Server < ActiveRecord::Base
belongs_to :server_pool
validates :server_pool, presence: true
has_many :accounts, through: :server_pool
has_many :users, through: :accounts
end
