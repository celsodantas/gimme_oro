class ChangeAmountFormatInEntriesTable < ActiveRecord::Migration
  def up
    change_column :entries, :amount, :decimal, :precision => 10, :scale => 4
  end

  def down
    change_column :entries, :amount, :float
  end
end
