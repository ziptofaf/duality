class Account < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  belongs_to :server_pool
  
  validates :server_pool, presence: true
  has_many :account_logs
  validates :user, presence: true
  validates :product, presence: true
  validates :login, presence: true
  validates :password, presence: true
  validates :expire, presence: true

end
