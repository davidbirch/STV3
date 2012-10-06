require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get privacy" do
    get :privacy
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

end
