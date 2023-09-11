require "test_helper"

class WorkoutPreferencesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get workout_preferences_new_url
    assert_response :success
  end

  test "should get create" do
    get workout_preferences_create_url
    assert_response :success
  end

  test "should get edit" do
    get workout_preferences_edit_url
    assert_response :success
  end

  test "should get update" do
    get workout_preferences_update_url
    assert_response :success
  end

  test "should get destroy" do
    get workout_preferences_destroy_url
    assert_response :success
  end
end
