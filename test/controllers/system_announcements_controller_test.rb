require 'test_helper'

class SystemAnnouncementsControllerTest < ActionController::TestCase
  setup do
    @system_announcement = system_announcements(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:system_announcements)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create system_announcement' do
    assert_difference('SystemAnnouncement.count') do
      post :create, params: { system_announcements: { content: @system_announcement.content, is_view: @system_announcement.is_view, title: @system_announcement.title } }
    end

    assert_redirected_to system_announcement_path(assigns(:system_announcement))
  end

  test 'should show system_announcement' do
    get :show, params: { id: @system_announcement }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @system_announcement }
    assert_response :success
  end

  test 'should update system_announcement' do
    patch :update, params: { id: @system_announcement, system_announcement: { content: @system_announcement.content, is_view: @system_announcement.is_view, title: @system_announcement.title } }
    assert_redirected_to system_announcement_path(assigns(:system_announcement))
  end

  test 'should destroy system_announcement' do
    assert_difference('SystemAnnouncement.count', -1) do
      delete :destroy, params: { id: @system_announcement }
    end

    assert_redirected_to system_announcements_path
  end
end
