require 'test_helper'

class UserReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_reviews_new_url
    assert_response :success
  end

  test "should get edit" do
    get user_reviews_edit_url
    assert_response :success
  end

end
