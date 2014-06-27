class Recovery < ActiveRecord::Base
  belongs_to :user
  validates :code, presence: true, uniqueness: {case_sensitive: true}
  validates :user, presence: true
end
