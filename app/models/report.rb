class Report < ApplicationRecord
  has_many :report_users, dependent: :destroy
  has_many :users, through: :report_users, dependent: :destroy

  has_many :comments, as: :commentable

  has_many :subreports, class_name: "Report", foreign_key: "report_id"
  
  belongs_to :report, class_name: "Report", optional: true

end
