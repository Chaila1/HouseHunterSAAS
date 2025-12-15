class Listing < ApplicationRecord
  validates :lister, :address, :beds, :baths, :catergory, :price, presence: true

  has_one_attached :image
  belongs_to :user

  def image_url
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end
end
