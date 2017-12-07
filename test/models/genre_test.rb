require 'test_helper'
require 'factory_bot'
class GenreTest < ActiveSupport::TestCase

  test "create genre valid is true" do
    genre = create(:genre)

    assert genre.valid?

  end





end
