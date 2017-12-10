require 'test_helper'
require 'factory_bot'

class EventTest < ActiveSupport::TestCase
  test "date is present" do
    event = build(:event, date: nil)
    refute event.valid?
  end

  test "date is in the future" do
    skip
    tomorrow = Time.now + 1.day
    event = build(:event, date: tomorrow)
    assert event.valid?
  end

  test "date cant be in the past" do
    skip
    yesterday = Time.now - 1.day
    event = build(:event, date: yesterday)
    refute event.valid?
  end


    test 'create event valid is true' do
     event = create(:event)


     assert event.valid?
   end

    test "test event belongs to artist" do
      artist =   Artist.create(artist_tm_id: 1)
      event = create(:event)
      event.artist = artist

      assert_equal event.artist, artist

    end

    test "test event has many images" do
      event = create(:event)
      image1 = Image.create(id: 1, event_id: 1)
      image2 = Image.create(id: 2, event_id: 1)
      event.images = []
      event.images << image1
      event.images << image2

      assert_equal event.images, [image1, image2]
    end
    test "test event belongs to venue" do
      venue = create(:venue)
      event = create(:event)
      event.venue = venue

      assert_equal event.venue, venue
    end

    test "event belongs to user" do
      event = create(:event)
      user = create(:user)
      event.user = user

      assert_equal event.user, user
    end

    test "event should not save without venue id" do
      event = build(:event, venue_id: nil)
      refute event.save
    end

end
