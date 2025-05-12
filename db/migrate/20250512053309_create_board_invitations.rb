class CreateBoardInvitations < ActiveRecord::Migration[8.0]
  def change
    create_table :board_invitations do |t|
      t.references :board, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :email, null: false
      t.string :token, null: false
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
