require 'test_helper'

class PictureControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get favorite_add" do
    get :favorite_add
    assert_response :success
  end

end
