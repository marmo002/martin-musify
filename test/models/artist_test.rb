require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  test "artist name must be presence" do
    artist1 = build(:artist, name: "")
    refute artist1.valid?
  end

  test "artist's tm id must be unique" do
    artist1 = create(:artist)
    artist2 = build(:artist)
    refute artist2.valid?
  end

  test "artist's tm id must be present" do
    artist1 = build(:artist, artist_tm_id: "")
    refute artist1.valid?
  end

end
