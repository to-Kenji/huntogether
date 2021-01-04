class AddDifficultyToTechniques < ActiveRecord::Migration[6.0]
  def change
    add_column :techniques, :difficulty, :integer
  end
end
