json.array!(@accounts) do |account|
  json.extract! account, :id, :login, :password, :level, :expire, :active, :user_id, :server_id, :product_id
  json.url account_url(account, format: :json)
end
