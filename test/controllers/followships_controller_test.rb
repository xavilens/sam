require 'test_helper'

class FollowshipsControllerTest < ActionController::TestCase
  test "should get index:get" do
    get :index:get
    assert_response :success
  end

  test "should get create:get" do
    get :create:get
    assert_response :success
  end

  test "should get destroy:delete" do
    get :destroy:delete
    assert_response :success
  end

end
