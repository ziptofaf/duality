class SpecialAccount < ActiveRecord::Base
  belongs_to :account
  validates :login, presence: true, uniqueness: { case_sensitive: true }
  validates :password, presence: true
  validates :account, presence: true
  validates :device, presence: true
end
