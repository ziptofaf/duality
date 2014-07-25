class ServerPool < ActiveRecord::Base
has_many :servers
has_many :accounts
end
