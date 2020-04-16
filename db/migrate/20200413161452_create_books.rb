class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books, id: false do |t|
      t.string :title, null: false, index: true
      t.string :slug, null: false, index: { unique: true }, primary: true
      t.string :author_id, null: false
      t.string :country
      t.string :language
      t.date :publication_date
      t.integer :pages
      t.string :isbn

      t.timestamps
    end

    add_foreign_key :books, :authors, column: :author_id, primary_key: :slug
    add_index :books, [:title, :author_id], unique: true
  end
end
