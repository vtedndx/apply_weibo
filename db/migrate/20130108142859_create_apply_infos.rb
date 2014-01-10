class CreateApplyInfos < ActiveRecord::Migration
  def change
    create_table :apply_infos do |t|
      t.integer :company_id
      t.string :name
      t.integer :share
      t.integer :backdrop_id
      t.string :img_url
      t.text :config_hash
      t.integer :status

      t.timestamps
    end
  end
end
