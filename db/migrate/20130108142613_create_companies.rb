class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :cid
      t.string :sub_appkey
      t.string :sns_uname
      t.string :sns_uimg
      t.text :config_hash
      t.datetime :expires_at
      t.string :sns_token

      t.timestamps
    end
  end
end
