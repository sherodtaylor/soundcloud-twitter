class ChangeColumnToInt < ActiveRecord::Migration
  def up
    connection.execute(%q{
      alter table users
      alter column soundcloud_id
      type integer using cast(soundcloud_id as integer)
    })
  end
end
