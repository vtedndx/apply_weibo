class CreateApplyElements < ActiveRecord::Migration
  def change
    create_table :apply_elements do |t|
      t.integer :apply_info_id
      t.integer :element_id
      t.text :config_hash
      t.string :partial_name
      t.integer :status

      t.timestamps
    end
  end
end
