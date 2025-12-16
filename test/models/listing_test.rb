require "test_helper"

class ListingTest < ActiveSupport::TestCase
def setup 
  @user = User.create!(
    username: "Jerome",
    email: "jerome@ruby.com",
    password: "password123"
  )

  @listing = Listing.new(
    lister: "Jerome Salazar",
    address: "45 Grange Street, Pinewview, Tallaght",
    beds: 3,
    baths: 2,
    catergory: "Apartment",
    price: 5390257,
    user: @user
  )
end

test "valid lisitng should be saved" do
  assert @listing.valid?
end

test "lisitngs should contain valid credentials" do
  @listing.lister = nil 
  assert_not @listing.valid?
end

test "listing belongs to an acutal user" do
  @listing.user = nil
  assert_not @listing.valid?
end
end
