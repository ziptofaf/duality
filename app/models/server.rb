class Server < ActiveRecord::Base
belongs_to :server_pool
VALID_IP = /\A\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\z/i
validates :server_pool, presence: true
validates :ip, format: {with: VALID_IP}
has_many :accounts, through: :server_pool
has_many :users, through: :accounts
before_create :autofill
before_save :capacityGuardian

def autofill
	if self.certname.empty?
		self.certname = self.cert_url.split(/\//).last
	end
	if self.capacity_current.nil?
		self.capacity_current = 0
	end
end

def capacityGuardian
	self.capacity_current = 0 if self.capacity_current < 0
end

end
