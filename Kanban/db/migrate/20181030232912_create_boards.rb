class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.string :name
      t.text :description
      t.integer :owner_id
      t.references :membership, foreign_key: true

      t.timestamps
    end
  end
end
