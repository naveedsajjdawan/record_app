class Report < ApplicationRecord
  has_many :report_users
  has_many :users, through: :report_users
end
