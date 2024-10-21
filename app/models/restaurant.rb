class Restaurant < ApplicationRecord
  has_many :menus

  validates :name, uniqueness: true, presence: true
end
