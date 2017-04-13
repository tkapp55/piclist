class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :media_url
      t.string :src_tweet

      t.timestamps null: false
    end
  end
end
