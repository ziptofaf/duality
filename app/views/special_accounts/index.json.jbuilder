json.array!(@special_accounts) do |special_account|
  json.extract! special_account, :id, :login, :password, :device, :account_id
  json.url special_account_url(special_account, format: :json)
end
