module DcLogHelper

def pathToScript
  return Rails.root.to_s + "/helper_scripts/forcedDisconnectionHelper"
end

def invokeScript(username, server_id="")
  system "#{pathToScript} #{username} #{timeNow} #{pathToLog} #{server_id}"
end

def timeNow
  return Time.now.to_s.gsub(" ", "---")
end

def pathToLog
  return Rails.root.to_s + "/log/forcedDisconnections.txt"
end

def cleanUp(account, server)
  server.capacity_current=server.capacity_current - account.active
  server.save
  account.active = 0
  account.save
end
end
