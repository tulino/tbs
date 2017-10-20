require 'test_helper'

class BlackListsControllerTest < ActionController::TestCase
  setup do
    @black_list = black_lists(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:black_lists)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create black_list' do
    assert_difference('BlackList.count') do
      post :create, black_list: { approve: @black_list.approve, club_id: @black_list.club_id, explanation: @black_list.explanation, user_id: @black_list.user_id }
    end

    assert_redirected_to black_list_path(assigns(:black_list))
  end

  test 'should show black_list' do
    get :show, id: @black_list
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @black_list
    assert_response :success
  end

  test 'should update black_list' do
    patch :update, id: @black_list, black_list: { approve: @black_list.approve, club_id: @black_list.club_id, explanation: @black_list.explanation, user_id: @black_list.user_id }
    assert_redirected_to black_list_path(assigns(:black_list))
  end

  test 'should destroy black_list' do
    assert_difference('BlackList.count', -1) do
      delete :destroy, id: @black_list
    end

    assert_redirected_to black_lists_path
  end
end
