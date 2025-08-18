class User < ApplicationRecord
  has_many :enrollment
  has_many :school_years, through: :enrollment
  before_save { |user| user.full_name = user.full_name.titleize }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { student: 0, teacher: 1, admin: 2 }

  validates :full_name, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  default_scope { order(full_name: :asc) }
end
