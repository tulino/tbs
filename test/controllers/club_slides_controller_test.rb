require 'test_helper'

class ClubSlidesControllerTest < ActionController::TestCase
  setup do
    @club_slide = club_slides(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:club_slides)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create club_slide' do
    assert_difference('ClubSlide.count') do
      post :create, params: { club_slide: { file: @club_slide.file, title: @club_slide.title } }
    end

    assert_redirected_to club_slide_path(assigns(:club_slide))
  end

  test 'should show club_slide' do
    get :show, params: { id: @club_slide }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @club_slide }
    assert_response :success
  end

  test 'should update club_slide' do
    patch :update, params: { id: @club_slide, club_slide: { file: @club_slide.file, title: @club_slide.title } }
    assert_redirected_to club_slide_path(assigns(:club_slide))
  end

  test 'should destroy club_slide' do
    assert_difference('ClubSlide.count', -1) do
      delete :destroy, params: { id: @club_slide }
    end

    assert_redirected_to club_slides_path
  end
end
