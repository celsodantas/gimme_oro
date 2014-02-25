class MaintenanceSetUserId < ActiveRecord::Migration
  def change
    Entry.update_all(user_id: User.first.id)
    Budget.update_all(user_id: User.first.id)
  end
end
