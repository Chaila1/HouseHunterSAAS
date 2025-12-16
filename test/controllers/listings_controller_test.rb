require "test_helper"
require "jwt"

class ListingsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(
      username: "Raquelle",
        email: "raquelle@ruby.com",
        password: "Password123"
    )


  payload = { user_id: @user.id }
  @token = JWT.encode(payload, Rails.application.secret_key_base, "HS256")

  @listing = Listing.create!(
    lister: "Raquelle Salazar",
    address: "54 Grange Street, Pinewview, Ballymun",
    beds: 3,
    baths: 2,
    catergory: "Apartment",
    price: 5390257,
    user: @user
  )
  end


  test "should get the index" do
    get "/listings"
    assert_response :success
  end

  test "should create listing" do
      post "/listings",
      params: {
        listing: {
          lister: "test",
          address: "54 Mule lane",
          beds: 3,
          baths: 2,
          catergory: "Apartment",
          price: 5390257
        }
      },
      headers: { Authorization: "Bearer #{@token}" }

      assert_response :success
    end

  test "should update listing" do
    patch "/listings/#{@listing.id}",
    params: { listing: { price: 300000 } },
    headers: { Authorization: "Bearer #{@token}" }

    assert_response :success
    assert_equal 300000, @listing.reload.price
  end

  test "should destroy listing" do
    assert_difference("Listing.count", -1) do
      delete "/listings/#{@listing.id}",
      headers: { Authorization: "Bearer #{@token}" }
    end

    assert_response :no_content
  end
end
