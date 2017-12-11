require 'test_helper'
require 'byebug'

class UserTest < ActiveSupport::TestCase

  test "email uniqueness returns false" do
    # byebug
    user1 = create(:user)
    user2 = build(:user)
    refute user2.valid?
  end

  test "email uniqueness returns true" do
    # byebug
    user1 = create(:user)
    user2 = build(:user, email: 'mail2@mail.com')
    assert user2.valid?
  end

  test "password confirmation is same as password" do
    user1 = build(:user, password_confirmation: 'password2')
    refute user1.valid?
  end

  test "password confirmation present" do
    user1 = build(:user, password_confirmation: "")
    refute user1.valid?
  end

  test "password length eigth" do
    user1 = build(:user, password: '1234', password_confirmation: '1234')
    refute user1.valid?
  end

  test  "user has many events" do
    event1 = build(:event, id: 1, user_id: 1)
    event2 = build(:event, id: 2, user_id: 1)
    user = create(:user)
    user.events << event1
    user.events << event2

    assert_equal user.events, [event1, event2]



  end

end
