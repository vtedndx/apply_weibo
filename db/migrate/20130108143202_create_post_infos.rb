class CreatePostInfos < ActiveRecord::Migration
  def change
    create_table :post_infos do |t|
      t.integer :company_id
      t.integer :apply_info_id
      t.integer :user_id
      t.timestamps
    end
  end
end
