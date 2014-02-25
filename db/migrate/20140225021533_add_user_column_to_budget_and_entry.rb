class AddUserColumnToBudgetAndEntry < ActiveRecord::Migration
  def change
    add_column :budgets, :user_id, :integer
    add_column :entries, :user_id, :integer
  end
end
