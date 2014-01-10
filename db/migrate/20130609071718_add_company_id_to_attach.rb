class AddCompanyIdToAttach < ActiveRecord::Migration
  def change
    add_column :attaches, :company_id, :integer
  end
end
