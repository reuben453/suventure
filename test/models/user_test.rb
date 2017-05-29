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

end
