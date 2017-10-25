require 'test_helper'

class AnnouncmentsControllerTest < ActionController::TestCase
  setup do
    @announcement = announcements(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:announcements)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create announcement' do
    assert_difference('announcement.count') do
      post :create, params: { announcement: { content: @announcement.content, period_id: @announcement.period_id, is_advisor_confirmation: @announcement.is_advisor_confirmation, is_view: @announcement.is_view, title: @announcement.title } }
    end

    assert_redirected_to announcment_path(assigns(:announcement))
  end

  test 'should show announcement' do
    get :show, params: { id: @announcement }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @announcement }
    assert_response :success
  end

  test 'should update announcement' do
    patch :update, params: { id: @announcement, announcement: { content: @announcement.content, period_id: @announcement.period_id, is_advisor_confirmation: @announcement.is_advisor_confirmation, is_view: @announcement.is_view, title: @announcement.title } }
    assert_redirected_to announcment_path(assigns(:announcement))
  end

  test 'should destroy announcement' do
    assert_difference('announcement.count', -1) do
      delete :destroy, params: { id: @announcement }
    end

    assert_redirected_to announcments_path
  end
end
