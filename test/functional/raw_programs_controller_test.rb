require 'test_helper'

class RawProgramsControllerTest < ActionController::TestCase
  setup do
    @raw_program = raw_programs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:raw_programs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create raw_program" do
    assert_difference('RawProgram.count') do
      post :create, raw_program: @raw_program.attributes
    end

    assert_redirected_to raw_program_path(assigns(:raw_program))
  end

  test "should show raw_program" do
    get :show, id: @raw_program
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @raw_program
    assert_response :success
  end

  test "should update raw_program" do
    put :update, id: @raw_program, raw_program: @raw_program.attributes
    assert_redirected_to raw_program_path(assigns(:raw_program))
  end

  test "should destroy raw_program" do
    assert_difference('RawProgram.count', -1) do
      delete :destroy, id: @raw_program
    end

    assert_redirected_to raw_programs_path
  end
end
