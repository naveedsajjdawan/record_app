class RemoveaddUserIdToReportsFromReports < ActiveRecord::Migration[6.1]
  def change
    remove_column :report, :user_id, :integer
  end
end
