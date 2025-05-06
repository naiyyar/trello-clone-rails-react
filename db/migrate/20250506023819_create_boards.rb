class CreateBoards < ActiveRecord::Migration[8.0]
  def change
    create_table :boards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :background

      t.timestamps
    end
  end
end
