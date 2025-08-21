require "test_helper"

class UserRegistrationTest < ActionDispatch::IntegrationTest
  test "user can sign up with valid details" do
    username = "janedoe123"
    
    assert_difference "User.count", 1 do
      post user_registration_path, params: {
        user: {
          first_name: "Jane",
          last_name: "Doe",
          username: username,
          email: "janedoe@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end
    
    user = User.find_by(email: "janedoe@example.com")

    #puts ">>> User.inspect = #{user.inspect}"
    #puts ">>> User.errors  = #{user.errors.full_messages}" if user.errors.any?

    follow_redirect!
    assert_response :success
    
    #assert_match "Welcome", response.body
    assert User.find_by(email: "janedoe@example.com")
    
    user = User.find_by(email: "janedoe@example.com")
    
    #puts "User email    = #{user.email}"
    #puts "User username = #{user.username}"
    assert_equal username, User.find_by(email: "janedoe@example.com").username
    #raise User.find_by(email: "janedoe@example.com").inspect
    assert_equal User.find_by(email: "janedoe@example.com"),  User.find_by(username: "janedoe123")
  end

  test "user cannot sign up with mismatched passwords" do
    assert_no_difference "User.count" do
      post user_registration_path, params: {
        user: {
          first_name: "John",
          last_name: "Smith",
          username: "johnsmith",
          email: "johnsmith@example.com",
          password: "password123",
          password_confirmation: "wrongpassword"
        }
      }
    end

    #assert_response :unprocessable_entity
    #assert_match "Password confirmation doesn't match", response.body
  end
end