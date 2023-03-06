class GroupExpenditure < ActiveRecord::Migration[7.0]
  def change
    create_table :category_expenditures do |t|
      t.references :groups, null: false, foreign_key: true
      t.references :expenditure, null: false, foreign_key: true

      t.timestamps
    end
  end
end
