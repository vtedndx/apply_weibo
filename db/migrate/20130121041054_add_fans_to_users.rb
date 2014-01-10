class AddFansToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fans, :integer
  end
end
