json.array!(@products) do |product|
  json.extract! product, :id, :name, :description, :ProductProcessor_id, :price, :parameters, :image
  json.url product_url(product, format: :json)
end
