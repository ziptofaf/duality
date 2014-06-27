class Payment < ActiveRecord::Base
  belongs_to :processor
  belongs_to :user
  validates :user, presence: true
  validates :processor, presence: true
end
