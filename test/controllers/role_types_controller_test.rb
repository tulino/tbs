require 'test_helper'

class RoleTypesControllerTest < ActionController::TestCase
  setup do
    @role_type = role_types(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:role_types)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create role_type' do
    assert_difference('RoleType.count') do
      post :create, params: { role_type: { name: @role_type.name } }
    end

    assert_redirected_to role_type_path(assigns(:role_type))
  end

  test 'should show role_type' do
    get :show, params: { id: @role_type }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @role_type }
    assert_response :success
  end

  test 'should update role_type' do
    patch :update, params: { id: @role_type, role_type: { name: @role_type.name } }
    assert_redirected_to role_type_path(assigns(:role_type))
  end

  test 'should destroy role_type' do
    assert_difference('RoleType.count', -1) do
      delete :destroy, params: { id: @role_type }
    end

    assert_redirected_to role_types_path
  end
end
