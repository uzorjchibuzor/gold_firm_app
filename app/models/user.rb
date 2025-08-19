class User < ApplicationRecord
  has_many :enrollment, dependent: :destroy
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

  ALLOWED_CLASSES = [ [ "JSS 1", "0"  ], [ "JSS 2", "1" ], [ "JSS 3", "2" ], [ "SSS 1", "3" ], [ "SSS 2", "4" ], [ "SSS 3", "5" ] ]
end
