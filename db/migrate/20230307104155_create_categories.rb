class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.references :author, foreign_key: { to_table: :users }, null: false
      t.string :name
      t.string :icon

      t.timestamps
    end
  end
end
