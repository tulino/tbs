require 'test_helper'

class ClubSettingsControllerTest < ActionController::TestCase
  setup do
    @club_setting = club_settings(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:club_settings)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create club_setting' do
    assert_difference('ClubSetting.count') do
      post :create, params: { club_setting: { period_id: @club_setting.period_id, max_user: @club_setting.max_user, program_id: @club_setting.program_id } }
    end

    assert_redirected_to club_setting_path(assigns(:club_setting))
  end

  test 'should show club_setting' do
    get :show, params: { id: @club_setting }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @club_setting }
    assert_response :success
  end

  test 'should update club_setting' do
    patch :update, params: { id: @club_setting, club_setting: { period_id: @club_setting.period_id, max_user: @club_setting.max_user, program_id: @club_setting.program_id } }
    assert_redirected_to club_setting_path(assigns(:club_setting))
  end

  test 'should destroy club_setting' do
    assert_difference('ClubSetting.count', -1) do
      delete :destroy, params: { id: @club_setting }
    end

    assert_redirected_to club_settings_path
  end
end
