class Friendship < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :user, foreign_key: true
      t.integer :friendship_id

      t.timestamps
    end
  end
end