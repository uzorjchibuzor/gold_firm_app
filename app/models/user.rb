# frozen_string_literal: true

class User < ApplicationRecord
  has_many :yearly_grade_levels, dependent: :destroy
  has_many :grade_levels, through: :yearly_grade_levels

  before_save { |user| user.full_name = user.full_name.titleize }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { student: 0, teacher: 1, admin: 2 }

  validates :full_name, presence: true, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  default_scope { where(disabled: false).order(full_name: :asc) }
end
