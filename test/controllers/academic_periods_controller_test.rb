require 'test_helper'

class AcademicPeriodsControllerTest < ActionController::TestCase
  setup do
    @academic_period = academic_periods(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:academic_periods)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create academic_period' do
    assert_difference('AcademicPeriod.count') do
      post :create, params: { academic_period: { is_active: @academic_period.is_active, name: @academic_period.name } }
    end

    assert_redirected_to academic_period_path(assigns(:academic_period))
  end

  test 'should show academic_period' do
    get :show, params: { id: @academic_period }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @academic_period }
    assert_response :success
  end

  test 'should update academic_period' do
    patch :update, params: { id: @academic_period, academic_period: { is_active: @academic_period.is_active, name: @academic_period.name } }
    assert_redirected_to academic_period_path(assigns(:academic_period))
  end

  test 'should destroy academic_period' do
    assert_difference('AcademicPeriod.count', -1) do
      delete :destroy, params: { id: @academic_period }
    end

    assert_redirected_to academic_periods_path
  end
end
