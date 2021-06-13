class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.integer :company_id

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
