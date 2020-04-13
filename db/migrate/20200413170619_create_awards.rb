class CreateAwards < ActiveRecord::Migration[6.0]
  def change
    create_table :awards, id: false do |t|
      t.string :name, null: false
      t.string :category, null: false
      t.string :slug, index: { unique: true }, null: false

      t.timestamps
    end

    add_index :awards, [:name, :category], unique: true
  end
end
