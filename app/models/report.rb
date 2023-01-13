class Report < ApplicationRecord
  has_many :report_users
  has_many :users, through: :report_users

  has_many :subreports, class_name: "Report", foreign_key: "report_id"
  
  belongs_to :report, class_name: "Report"

end
