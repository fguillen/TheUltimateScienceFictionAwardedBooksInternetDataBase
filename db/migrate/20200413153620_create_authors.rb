class CreateAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :authors, id: false do |t|
      t.string :name, index: { unique: true }, null: false
      t.string :slug, index: { unique: true }, null: false
    end
  end
end
