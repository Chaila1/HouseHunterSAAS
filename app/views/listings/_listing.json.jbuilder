json.extract! listing, :id, :lister, :address, :beds, :baths, :catergory, :price, :created_at, :updated_at
json.url listing_url(listing, format: :json)
