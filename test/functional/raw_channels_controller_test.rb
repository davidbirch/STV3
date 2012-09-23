require 'test_helper'

class RawChannelsControllerTest < ActionController::TestCase
  setup do
    @raw_channel = raw_channels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:raw_channels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create raw_channel" do
    assert_difference('RawChannel.count') do
      post :create, raw_channel: @raw_channel.attributes
    end

    assert_redirected_to raw_channel_path(assigns(:raw_channel))
  end

  test "should show raw_channel" do
    get :show, id: @raw_channel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @raw_channel
    assert_response :success
  end

  test "should update raw_channel" do
    put :update, id: @raw_channel, raw_channel: @raw_channel.attributes
    assert_redirected_to raw_channel_path(assigns(:raw_channel))
  end

  test "should destroy raw_channel" do
    assert_difference('RawChannel.count', -1) do
      delete :destroy, id: @raw_channel
    end

    assert_redirected_to raw_channels_path
  end
end
