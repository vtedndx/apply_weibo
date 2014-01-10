class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.integer :company_id
      t.string :sns_uname
      t.string :sns_uimg
      t.string :desp

      t.timestamps
    end
  end
end
