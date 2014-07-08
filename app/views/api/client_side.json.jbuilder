 json.array!(@test) do |account|
  json.extract! account, :login, :password, :cert_url, :certname, :ip, :location, :level
 end

