class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :twitter_connect, :boolean
  end
end
