json.array!(@accounts) do |account|
  json.extract! account, :id, :login, :password, :expire, :active, :user_id, :server_pool_id, :product_id
  json.url account_url(account, format: :json)
end
