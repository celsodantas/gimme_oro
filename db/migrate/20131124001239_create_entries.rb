class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :description
      t.datetime :date
      t.string :entry_type
      t.float :amount

      t.timestamps
    end
  end
end
