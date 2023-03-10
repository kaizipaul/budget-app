class CreateExpenditures < ActiveRecord::Migration[7.0]
  def change
    create_table :expenditures do |t|
      t.references :author, foreign_key: { to_table: :users }, null: false
      t.string :name
      t.decimal :amount

      t.timestamps
    end
  end
end
