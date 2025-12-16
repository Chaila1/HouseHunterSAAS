require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(
      username: "Shaniqua",
        email: "shaniqua@ruby.com",
        password: "Password123"
    )
  end

  test "correct login" do
    post "/login", params: {
      user: {
        username: "Shaniqua",
        password: "Password123"
      }
    }

    assert_response :ok
    json = JSON.parse(response.body)
    assert json["token"].present?
  end

  test "incorrect login" do
    post "/login", params: {
      user: {
        username: "Shaniqua",
        password: "wrongpassword"
      }
    }

    assert_response :unauthorized
  end
end
