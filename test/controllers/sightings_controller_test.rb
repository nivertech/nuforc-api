require 'test_helper'

class SightingsControllerTest < ActionController::TestCase
  setup do
    @sighting = sightings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sightings)
  end

  test "should create sighting" do
    assert_difference('Sighting.count') do
      post :create, sighting: { city: @sighting.city, duration: @sighting.duration, posted_on: @sighting.posted_on, seen_when: @sighting.seen_when, shape: @sighting.shape, state: @sighting.state, summary: @sighting.summary }
    end

    assert_response 201
  end

  test "should show sighting" do
    get :show, id: @sighting
    assert_response :success
  end

  test "should update sighting" do
    put :update, id: @sighting, sighting: { city: @sighting.city, duration: @sighting.duration, posted_on: @sighting.posted_on, seen_when: @sighting.seen_when, shape: @sighting.shape, state: @sighting.state, summary: @sighting.summary }
    assert_response 204
  end

  test "should destroy sighting" do
    assert_difference('Sighting.count', -1) do
      delete :destroy, id: @sighting
    end

    assert_response 204
  end
end
