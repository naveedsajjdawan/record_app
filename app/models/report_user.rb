class ReportUser < ApplicationRecord
  belongs_to :report
  belongs_to :user
  #  validates :report_id, :user_id, uniqueness: true, presence: true
end 