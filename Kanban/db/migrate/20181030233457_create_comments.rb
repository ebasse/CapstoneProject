class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :id
      t.text :body
      t.string :title

      t.timestamps
    end
  end
end