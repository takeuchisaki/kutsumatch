require "test_helper"

class Admin::ShoeCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_shoe_comments_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_shoe_comments_show_url
    assert_response :success
  end
end
