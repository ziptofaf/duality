 json.array!(@test) do |account|
  json.extract! account, :login, :password, :cert_url, :ip, :location, :level
 end

