class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  monetize :price_cents, allow_nil: true  
  
  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user_id }

  def draft?
    !published?
  end
end
