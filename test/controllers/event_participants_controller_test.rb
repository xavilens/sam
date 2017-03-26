require 'test_helper'

class EventParticipantsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

  test "should get send_request" do
    get :send_request
    assert_response :success
  end

  test "should get send_request_message" do
    get :send_request_message
    assert_response :success
  end

end
