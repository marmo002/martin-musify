require 'test_helper'
require 'byebug'

class UserTest < ActiveSupport::TestCase

  test "test email uniqueness returns false" do
    # byebug
    user1 = create(:user)
    user2 = build(:user)
    refute user2.valid?
  end

  test "test email uniqueness returns true" do
    # byebug
    user1 = create(:user)
    user2 = build(:user, email: 'mail2@mail.com')
    assert user2.valid?
  end

end
