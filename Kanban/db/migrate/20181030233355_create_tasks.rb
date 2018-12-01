class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :progress
      t.float :x
      t.float :y
      t.references :board, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
