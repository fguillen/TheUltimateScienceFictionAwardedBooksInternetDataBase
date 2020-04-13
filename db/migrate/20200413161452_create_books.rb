class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books, id: false do |t|
      t.string :title, null: false, unique: true
      t.string :slug, null: false, unique: true, primary: true
      t.string :author_id, null: false
      t.string :country
      t.string :language
      t.date :publication_date
      t.integer :pages
      t.string :isbn

      t.timestamps
    end

    add_foreign_key :books, :authors, column: :author_id, primary_key: :slug
  end
end
