require 'test_helper'

class VenueTest < ActiveSupport::TestCase
  test "venue name present" do
    venue1 = build(:venue, name: "")
    refute venue1.valid?
  end

  test "venue's tm id uniqueness returns true" do
    venue1 = create(:venue)
    venue2 = build(:venue, venue_tm_id: "test2")
    assert venue2.valid?
  end

  test "venue's tm id must be present" do
    venue1 = build(:venue, venue_tm_id: "")
    refute venue1.valid?
  end

  test "venue's address 1 must be present" do
    venue1 = build(:venue, address_1: "")
    refute venue1.valid?
  end

  test "venue's city must be present" do
    venue1 = build(:venue, city: "")
    refute venue1.valid?
  end

  test "venue's province must be present" do
    venue1 = build(:venue, province: "")
    refute venue1.valid?
  end

  test "venue's postal_code must be present" do
    venue1 = build(:venue, postal_code: "")
    refute venue1.valid?
  end

  test "venue's country must be present" do
    venue1 = build(:venue, country: "")
    refute venue1.valid?
  end



end
