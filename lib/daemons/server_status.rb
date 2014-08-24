#!/usr/bin/env ruby
require 'net/ping'
# You might want to change this
ENV["RAILS_ENV"] ||= "production"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
Dir.chdir(root)

require File.join(root, "config", "environment")

$running = true
Signal.trap("TERM") do
  $running = false
end

while($running) do
  servers = Server.all
  servers.each do |server|
  ip = server.ip
  result = Net::Ping::TCP.new(ip)
  ping = result.ping?
  if ping
    server.status = "online"
  else
    server.status = "offline"
  end
  server.save
end
sleep 5
# Replace this with your code
# Rails.logger.auto_flushing = true
# Rails.logger.info "This daemon is still running at #{Time.now}.\n"
# Rails.logger.info "lets seee if this works"

# f = File.open('/home/marcin/file.txt', 'a')
# f.puts "hello"
# sleep 0.1
# f.close

end
