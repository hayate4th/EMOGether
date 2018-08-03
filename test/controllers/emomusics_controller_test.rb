require 'test_helper'

class EmomusicsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @emomusic = emomusics(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Emomusic.count' do
      post emomusics_path, params: { emomusic: { title: "emomusic1", composer: "emo man1" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Emomusic.count' do
      delete emomusic_path(@emomusic)
    end
    assert_redirected_to login_url
  end
end
