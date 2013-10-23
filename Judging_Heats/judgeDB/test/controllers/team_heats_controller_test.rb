require 'test_helper'

class TeamHeatsControllerTest < ActionController::TestCase
  setup do
    @team_heat = team_heats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:team_heats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team_heat" do
    assert_difference('TeamHeat.count') do
      post :create, team_heat: { heat_id: @team_heat.heat_id, judge_id: @team_heat.judge_id, score: @team_heat.score, team_id: @team_heat.team_id }
    end

    assert_redirected_to team_heat_path(assigns(:team_heat))
  end

  test "should show team_heat" do
    get :show, id: @team_heat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @team_heat
    assert_response :success
  end

  test "should update team_heat" do
    patch :update, id: @team_heat, team_heat: { heat_id: @team_heat.heat_id, judge_id: @team_heat.judge_id, score: @team_heat.score, team_id: @team_heat.team_id }
    assert_redirected_to team_heat_path(assigns(:team_heat))
  end

  test "should destroy team_heat" do
    assert_difference('TeamHeat.count', -1) do
      delete :destroy, id: @team_heat
    end

    assert_redirected_to team_heats_path
  end
end
