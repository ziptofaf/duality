class Account < ActiveRecord::Base
  belongs_to :user
  belongs_to :server
  belongs_to :product
  has_many :account_logs
  validates :user, presence: true
  validates :server, presence: true
  validates :product, presence: true
  validates :login, presence: true
  validates :password, presence: true
  validates :expire, presence: true

  after_create do |record|
  result = Server.find(record.server_id)
  modification = (result.capacity_current)+1
  result.capacity_current=modification
  result.save
  end

  after_destroy do |record| 
  result = Server.find(record.server_id)
  modification = (result.capacity_current)-1
  result.capacity_current=modification
  result.save
 end
end
