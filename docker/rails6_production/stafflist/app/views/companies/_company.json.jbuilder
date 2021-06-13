json.extract! company, :id, :name, :street_address, :postcode, :country_name, :created_at, :updated_at
json.url company_url(company, format: :json)
