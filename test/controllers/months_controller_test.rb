require 'test_helper'

class MonthsControllerTest < ActionController::TestCase
  setup do
    @month = months(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:months)
  end

  test "should create month" do
    assert_difference('Month.count') do
      post :create, month: { count: @month.count, date: @month.date }
    end

    assert_response 201
  end

  test "should show month" do
    get :show, id: @month
    assert_response :success
  end

  test "should update month" do
    put :update, id: @month, month: { count: @month.count, date: @month.date }
    assert_response 204
  end

  test "should destroy month" do
    assert_difference('Month.count', -1) do
      delete :destroy, id: @month
    end

    assert_response 204
  end
end
