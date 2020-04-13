class CreateAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :authors, id: false do |t|
      t.string :name, unique: true, null: false
      t.string :slug, unique: true, null: false, primary: true
    end
  end
end
