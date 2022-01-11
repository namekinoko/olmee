class ChangPostsToGroups < ActiveRecord::Migration[6.1]
  def change
    rename_table :posts, :groups
  end
end
