class CreateTechniques < ActiveRecord::Migration[6.0]
  def change
    create_table :techniques do |t|
      t.string :title
      t.text :body
      t.string :youtube_url
      t.references :user, null: false, foreign_key: true
      t.references :weapon, null: false, foreign_key: true
      t.references :monster, null: false, foreign_key: true

      t.timestamps
    end
  end
end
