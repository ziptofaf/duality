json.array!(@servers) do |server|
  json.extract! server, :id, :ip, :location, :server_pool_id, :capacity_current, :cert_url, :certname
  json.url server_url(server, format: :json)
end
