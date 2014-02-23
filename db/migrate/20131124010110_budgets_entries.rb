class BudgetsEntries < ActiveRecord::Migration
  def change
    create_table :budgets_entries do |t|
      t.integer :budget_id
      t.integer :entry_id

      t.timestamps
    end
  end
end
