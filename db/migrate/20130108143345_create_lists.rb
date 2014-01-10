class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.integer :company_id
      t.integer :apply_info_id
      t.integer :user_id
      t.integer :status

      t.timestamps
    end
  end
end
