class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,  :trackable
         
      has_many :posts
      has_many :report_users
      has_many  :reports, through: :report_users 
       

  scope :not_active_user, ->(id) { where.not(id: id) }
end
