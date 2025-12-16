require "test_helper"

class RegistersControllerTest < ActionDispatch::IntegrationTest
  test "create a user" do
    post "/register", params: {
      user:{
        username: "Peter",
        email: "peter@ruby.com",
        password: "Password123"
      }
    }

    assert_response :created
    user = User.find_by(email: "peter@ruby.com")
    assert_not_nil user
    assert_equal "Peter", user.username
    assert user.authenticate("Password123")
  end

  test "input fields must be filled" do 
    post "/register", params: {
      user:{
        username: "",
        email: "",
        password: ""
      }
    }

    assert_response :unprocessable_entity
  end
end