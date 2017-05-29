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

end
