module ZipHelper
require 'securerandom'

 def scriptPath
  Rails.root.to_s + "/helper_scripts/zipGenerator"
 end

 def archiveName
  random_string = SecureRandom.base64(30)
  random_string.split(/[+,=\/]/).join
 end

 def certUrl(server)
  Rails.root.to_s + "/public" + server.cert_url
 end

 def serverPort(server)
  "443"
 end

 def currentPath
  Rails.root.to_s + "/helper_scripts"
 end

 def packPath
  Rails.root.to_s + "/zipPacks"
 end

 def toSendPath(filename)
  packPath+"/"+filename+".zip"
 end

end
