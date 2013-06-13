class ChangeColumnToInt < ActiveRecord::Migration
  def change
    change_column :users, :soundcloud_id, :integer
  end
end
