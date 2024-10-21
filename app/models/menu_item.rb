class MenuItem < ApplicationRecord
  belongs_to :item
  belongs_to :menu

  validates :price, presence: true
  validates :item, presence: true, uniqueness: { scope: :menu }
end
