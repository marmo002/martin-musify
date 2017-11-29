require 'test_helper'

class VenueTest < ActiveSupport::TestCase
  test "venue name present" do
    venue1 = build(:venue)
    assert venue1.valid?
  end
end
