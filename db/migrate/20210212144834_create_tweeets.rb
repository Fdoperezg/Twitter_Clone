class CreateTweeets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweeets do |t|
      t.string :content
      t.integer :user_id
      t.integer :tweet_id
      t.integer :retweets_count

      t.timestamps
    end
  end
end
