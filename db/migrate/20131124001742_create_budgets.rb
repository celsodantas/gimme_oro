class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :description
      t.float :amount

      t.timestamps
    end
  end
end
