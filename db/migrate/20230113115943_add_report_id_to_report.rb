class AddReportIdToReport < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :report_id, :integer
  end
end
