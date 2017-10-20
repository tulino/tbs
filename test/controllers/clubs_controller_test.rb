require 'test_helper'

class ClubsControllerTest < ActionController::TestCase
  setup do
    @club = clubs(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:clubs)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create club' do
    assert_difference('Club.count') do
      post :create, params: { club: { creation_date: @club.creation_date, description: @club.description, name: @club.name, short_name: @club.short_name } }
    end

    assert_redirected_to club_path(assigns(:club))
  end

  test 'should show club' do
    get :show, params: { id: @club }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @club }
    assert_response :success
  end

  test 'should update club' do
    patch :update, params: { id: @club, club: { creation_date: @club.creation_date, description: @club.description, name: @club.name, short_name: @club.short_name } }
    assert_redirected_to club_path(assigns(:club))
  end

  test 'should destroy club' do
    assert_difference('Club.count', -1) do
      delete :destroy, params: { id: @club }
    end

    assert_redirected_to clubs_path
  end
end
