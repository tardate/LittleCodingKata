class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :street_address
      t.string :postcode
      t.string :country_name

      t.timestamps
    end
  end
end
