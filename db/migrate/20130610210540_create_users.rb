class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :soundcloud_token
      t.string :soundcloud_id
      t.string :twitter_token
      t.string :twitter_id

      t.timestamps
    end
  end
end
