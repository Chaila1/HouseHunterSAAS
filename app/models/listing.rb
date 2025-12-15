class Listing < ApplicationRecord
  validates :lister, :address, :beds, :baths, :catergory, :price presence true
  has_one_attached :image
  belongs_to :user
end
