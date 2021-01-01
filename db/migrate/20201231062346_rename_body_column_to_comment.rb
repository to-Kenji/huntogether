class RenameBodyColumnToComment < ActiveRecord::Migration[6.0]
  def change
    rename_column :comments, :body, :content
  end
end
