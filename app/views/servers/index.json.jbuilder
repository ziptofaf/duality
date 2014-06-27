json.array!(@servers) do |server|
  json.extract! server, :id, :ip, :location, :capacity_max, :capacity_current, :cert_url, :level
  json.url server_url(server, format: :json)
end
