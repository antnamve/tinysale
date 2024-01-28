class Content < ApplicationRecord
  belongs_to :product, optional: true
  validates :name, presence: true

  has_one_attached :file
end
