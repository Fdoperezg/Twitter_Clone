class AddFieldsToTweeets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweeets, :tweeet_id, :integer
    add_index :tweeets, :tweeet_id
    add_index :tweeets, :user_id
  end
end
