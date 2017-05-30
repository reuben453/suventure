require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "username validations @" do
    user = User.create(username: "asf@fg.com", email: "some@thing.com", password: "password")
    assert_equal(1, user.errors.messages.length)
    assert_equal(["is invalid"], user.errors.messages[:username])
  end

  test "username validations %" do
    user = User.create(username: "asf%fg", email: "some@thing.com", password: "password")
    assert_equal(1, user.errors.messages.length)
    assert_equal(["is invalid"], user.errors.messages[:username])
  end

  test "username validations &" do
    user = User.create(username: "asf&fg", email: "some@thing.com", password: "password")
    assert_equal(1, user.errors.messages.length)
    assert_equal(["is invalid"], user.errors.messages[:username])
  end

  test "username validations *" do
    user = User.create(username: "asf*fg", email: "some@thing.com", password: "password")
    assert_equal(1, user.errors.messages.length)
    assert_equal(["is invalid"], user.errors.messages[:username])
  end

  test "username validations |" do
    user = User.create(username: "asf|fg", email: "some@thing.com", password: "password")
    assert_equal(1, user.errors.messages.length)
    assert_equal(["is invalid"], user.errors.messages[:username])
  end

  test "username validations allowed chars" do
    user = User.create(username: "asf_.AS56fg", email: "some@thing.com", password: "password")
    assert_equal(0, user.errors.messages.length)
  end

  test "duplicate usernames" do
    user = User.create(username: "test", email: "some@thing.com", password: "password")
    assert_equal(0, user.errors.messages.length)
    user1 = User.create(username: "test", email: "other@thing.com", password: "password")
    assert_equal(1, user1.errors.messages.length)
    assert_equal(["has already been taken"], user1.errors.messages[:username])
  end

  test "duplicate emails" do
    user = User.create(username: "test", email: "some@thing.com", password: "password")
    assert_equal(0, user.errors.messages.length)
    user1 = User.create(username: "test1", email: "some@thing.com", password: "password")
    assert_equal(1, user1.errors.messages.length)
    assert_equal(["has already been taken"], user1.errors.messages[:email])
  end

  test "add message after signup" do
    user = User.create!(username: "test", email: "some@thing.com", password: "password")
    assert_equal(1, user.messages.size)
    assert_equal("You have signed up for this app.", user.messages.first.content)
    assert_equal(Message::EVENT_SIGNUP, user.messages.first.event)
  end

  test "add message after email confirmation" do
    user = User.create!(username: "test", email: "some@thing.com", password: "password")
    assert_equal(1, user.messages.size)
    user.confirm
    assert_equal(2, user.messages.size)
    assert_equal(Message::EVENT_EMAIL_CONFIRMED, user.messages.last.event)
    assert_equal("You have confirmed your email #{user.email}", user.messages.last.content)
  end

  test "regenerate token" do
    user = User.create!(username: "test", email: "some@thing.com", password: "password")
    token = user.authentication_token
    assert_not_empty(token)
    user.regenerate_token
    assert_not_empty(user.authentication_token)
    assert_not_equal(user.authentication_token, token)
  end

end
