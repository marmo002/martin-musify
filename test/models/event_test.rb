require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "date is present" do
    event = build(:event, date: nil)
    refute event.valid?
  end

  test "date is in the future" do
    tomorrow = Time.now + 1.day
    event = build(:event, date: tomorrow)
    assert event.valid?
  end

  test "date cant be in the past" do
    yesterday = Time.now - 1.day
    event = build(:event, date: yesterday)
    refute event.valid?
  end
end
