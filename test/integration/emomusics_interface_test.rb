require 'test_helper'

class EmomusicsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "emomusic interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # 無効な送信
    assert_no_difference 'Emomusic.count' do
      post emomusics_path, params: { emomusic: { titile: "", composer: "" } }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    title = "emomusic1"
    composer = "emo man1"
    assert_difference 'Emomusic.count', 1 do
      post emomusics_path, params: { emomusic: { title: title, composer: composer } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match title, response.body
    assert_match composer, response.body
    # 投稿を削除する
    assert_select 'a', text: 'delete'
    first_emomusic = @user.emomusics.paginate(page: 1).first
    assert_difference 'Emomusic.count', -1 do
      delete emomusic_path(first_emomusic)
    end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end

  test "emomusic sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.emomusics.count} emomusics", response.body
    # まだマイクロポストを投稿していないユーザー
    other_user = users(:malory)
    log_in_as(other_user)
    get root_path
    assert_match "0 emomusics", response.body
    other_user.emomusics.create!(title: "emomusic2", composer: "emo man2")
    get root_path
    assert_match "1 emomusic", response.body
  end
end