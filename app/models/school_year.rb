class SchoolYear < ApplicationRecord
  has_many :enrollment
  has_many :users, through: :enrollment
end
