class RemoveDifficultyFromTechniques < ActiveRecord::Migration[6.0]
  def change
    remove_column :techniques, :difficulty, :string
  end
end
