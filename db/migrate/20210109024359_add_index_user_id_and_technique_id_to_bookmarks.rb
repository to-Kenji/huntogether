class AddIndexUserIdAndTechniqueIdToBookmarks < ActiveRecord::Migration[6.0]
  def change
    add_index :bookmarks, [:user_id, :technique_id], unique: true
  end
end
