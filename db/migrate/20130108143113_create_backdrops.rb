class CreateBackdrops < ActiveRecord::Migration
  def change
    create_table :backdrops do |t|

      t.timestamps
    end
  end
end
