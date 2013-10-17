require 'test_helper'

class DancerTeamsControllerTest < ActionController::TestCase
  setup do
    @dancer_team = dancer_teams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dancer_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dancer_team" do
    assert_difference('DancerTeam.count') do
      post :create, dancer_team: { dancer_id: @dancer_team.dancer_id, team_id: @dancer_team.team_id }
    end

    assert_redirected_to dancer_team_path(assigns(:dancer_team))
  end

  test "should show dancer_team" do
    get :show, id: @dancer_team
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dancer_team
    assert_response :success
  end

  test "should update dancer_team" do
    patch :update, id: @dancer_team, dancer_team: { dancer_id: @dancer_team.dancer_id, team_id: @dancer_team.team_id }
    assert_redirected_to dancer_team_path(assigns(:dancer_team))
  end

  test "should destroy dancer_team" do
    assert_difference('DancerTeam.count', -1) do
      delete :destroy, id: @dancer_team
    end

    assert_redirected_to dancer_teams_path
  end
end
