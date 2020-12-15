class ChangeFavoritesToLikes < ActiveRecord::Migration[6.0]
  def change
    rename_table :favorites, :likes
  end
end
