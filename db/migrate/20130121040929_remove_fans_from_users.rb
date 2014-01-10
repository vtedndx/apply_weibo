class RemoveFansFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :fans
  end

  def down
    add_column :users, :fans, :string
  end
end
