require 'test_helper'

class ClubCategoriesControllerTest < ActionController::TestCase
  setup do
    @club_category = club_categories(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:club_categories)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create club_category' do
    assert_difference('ClubCategory.count') do
      post :create, params: { club_category: { name: @club_category.name } }
    end

    assert_redirected_to club_category_path(assigns(:club_category))
  end

  test 'should show club_category' do
    get :show, params: { id: @club_category }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @club_category }
    assert_response :success
  end

  test 'should update club_category' do
    patch :update, params: { id: @club_category, club_category: { name: @club_category.name } }
    assert_redirected_to club_category_path(assigns(:club_category))
  end

  test 'should destroy club_category' do
    assert_difference('ClubCategory.count', -1) do
      delete :destroy, params: { id: @club_category }
    end

    assert_redirected_to club_categories_path
  end
end
