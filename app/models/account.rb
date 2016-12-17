class Account < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  belongs_to :server_pool

  validates :server_pool, presence: true
  has_many :account_logs
  has_many :special_accounts
  validates :user, presence: true
  #validates :product, presence: true
  validates :login, presence: true, uniqueness: { case_sensitive: true }
  validates :password, presence: true
  validates :expire, presence: true
  validates :active, presence: true
after_validation :statusGuard

def statusGuard
self.active = 0 if self.active < 0
end

end
