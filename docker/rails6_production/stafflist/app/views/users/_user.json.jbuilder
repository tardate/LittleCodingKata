json.extract! user, :id, :email, :name, :company_id, :created_at, :updated_at
json.url user_url(user, format: :json)
