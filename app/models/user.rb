class User < ActiveRecord::Base
  has_secure_password
VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i 
validates :email, presence: true, length: { maximum:100}, format: {with: VALID_EMAIL}, uniqueness: { case_sensitive: false }
validates :active, presence: true
validates :password, length: { minimum: 6, maximum: 100}
has_many :accounts, dependent: :destroy
has_many :account_logs, :through => :accounts
before_create {sleep 0.04}
end
