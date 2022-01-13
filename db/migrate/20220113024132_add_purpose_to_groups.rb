class AddPurposeToGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :purpose, :string
  end
end
