class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :sns_uid
      t.string :sns_uname
      t.string :sns_uimg
      t.string :sns_token
      t.datetime :expires_at
      t.integer :verified_type
      t.string :fans
      t.string :location
      t.string :friends
      t.string :statuses
      t.string :description
      t.string :label
      t.string :remark

      t.timestamps
    end
  end
end
