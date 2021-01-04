class ChangeDatatypeDifficultyOfTechniques < ActiveRecord::Migration[6.0]
  def change
    change_column :techniques, :difficulty, :string
  end
end
