require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      username: "testuser",
      email: "test@example.com",
      password: "password123"
    )
  end

  test "valid user should get saved" do
    assert @user.valid?
  end

  test "gotta have a username" do
    @user.username = nil
    assert_not @user.valid?
  end

  test "gotta have an email" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "username must be unique" do
    @user.save!
    duplicate_user = @user.dup
    assert_not duplicate_user.valid?
  end

  test "password should be encrypted" do
    @user.save!
    assert_not_equal "passwprd123", @user.password_digest
    assert @user.authenticate("password123")
  end
end
