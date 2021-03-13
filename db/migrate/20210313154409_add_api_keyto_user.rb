class AddApiKeytoUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :api_key, :string
    User.find_each do |am|
      api_key = am.generate_api_key
      am.update_columns(api_key: api_key)
    end
    change_column :users, :api_key, :string, unique: true, null: false
    add_index :users, :api_key, unique: true 
  end
end