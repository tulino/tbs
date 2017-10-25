require 'test_helper'

class RolesControllerTest < ActionController::TestCase
  setup do
    @role = roles(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:roles)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create role' do
    assert_difference('Role.count') do
      post :create, params: { role: { club_id: @role.club_id, period_id: @role.period_id, name: @role.name } }
    end

    assert_redirected_to role_path(assigns(:role))
  end

  test 'should show role' do
    get :show, params: { id: @role }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @role }
    assert_response :success
  end

  test 'should update role' do
    patch :update, params: { id: @role, role: { club_id: @role.club_id, period_id: @role.period_id, name: @role.name } }
    assert_redirected_to role_path(assigns(:role))
  end

  test 'should destroy role' do
    assert_difference('Role.count', -1) do
      delete :destroy, params: { id: @role }
    end

    assert_redirected_to roles_path
  end
end
