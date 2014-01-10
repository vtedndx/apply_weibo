class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string :sns_uid
      t.integer :company_id
      t.string :sns_uimg
      t.string :sns_uname

      t.timestamps
    end
  end
end
