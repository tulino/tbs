require 'test_helper'

class ClubPeriodsControllerTest < ActionController::TestCase
  setup do
    @club_period = club_periodss(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:club_periods)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create club_period' do
    assert_difference('ClubPeriod.count') do
      post :create, params: { club_period: { club_id: @club_period.club_id, is_active: @club_period.is_active, name: @club_period.name } }
    end

    assert_redirected_to club_period_path(assigns(:club_period))
  end

  test 'should show club_period' do
    get :show, params: { id: @club_period }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @club_period }
    assert_response :success
  end

  test 'should update club_period' do
    patch :update, params: { id: @club_period, club_period: { club_id: @club_period.club_id, is_active: @club_period.is_active, name: @club_period.name } }
    assert_redirected_to club_period_path(assigns(:club_period))
  end

  test 'should destroy club_period' do
    assert_difference('ClubPeriod.count', -1) do
      delete :destroy, params: { id: @club_period }
    end

    assert_redirected_toclub_period_path
  end
end
