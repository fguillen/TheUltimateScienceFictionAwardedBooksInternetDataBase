class CreateAwardWinners < ActiveRecord::Migration[6.0]
  def change
    create_table :award_winners do |t|
      t.string :award_id, null: false
      t.integer :year, null: false
      t.string :position, null: false
      t.string :book_id, null: false

      t.timestamps
    end

    add_foreign_key :award_winners, :awards, column: :award_id, primary_key: :slug
    add_foreign_key :award_winners, :books, column: :book_id, primary_key: :slug
  end
end
