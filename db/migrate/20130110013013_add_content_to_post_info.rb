class AddContentToPostInfo < ActiveRecord::Migration
  def change
    add_column :post_infos, :content, :text
    add_column :post_infos, :status, :integer
  end
end
