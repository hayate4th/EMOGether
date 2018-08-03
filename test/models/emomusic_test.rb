require 'test_helper'

class EmomusicTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @emomusic = @user.emomusics.build(title: "emo music", composer: "emoman")
  end

  test "should be valid" do
    assert @emomusic.valid?
  end

  test "user id should be present" do
    @emomusic.user_id = nil
    assert_not @emomusic.valid?
  end

  test "title should be present" do
    @emomusic.title = "   "
    assert_not @emomusic.valid?
  end

  test "title should be at most 140 characters" do
    @emomusic.title = "a" * 141
    assert_not @emomusic.valid?
  end

  test "composer should be present" do
    @emomusic.composer = "   "
    assert_not @emomusic.valid?
  end

  test "composer should be at most 140 characters" do
    @emomusic.composer = "a" * 141
    assert_not @emomusic.valid?
  end

  test "order should be most recent first" do
    assert_equal emomusics(:most_recent), Emomusic.first
  end
end
