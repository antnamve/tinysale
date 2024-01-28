class Product < ApplicationRecord
  extend FriendlyId
  validates :name, presence: true, uniqueness: { scope: :user_id }

  friendly_id :name, use: :slugged
  monetize :price_cents, allow_nil: true  
  has_rich_text :description
  
  belongs_to :user
  has_many :contents, dependent: :destroy
  has_one_attached :thumbnail
  has_one_attached :cover

  def draft?
    !published?
  end
end
