require 'test_helper'

class ListsControllerTest < ActionController::TestCase
  setup do
    @list = lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create list" do
    assert_difference('List.count') do
      post :create, list: { accountant_id: @list.accountant_id, member_one: @list.member_one, member_three: @list.member_three, member_two: @list.member_two, president_id: @list.president_id, secretary_id: @list.secretary_id, selection_id: @list.selection_id, vice_president_id: @list.vice_president_id, vote_count: @list.vote_count }
    end

    assert_redirected_to list_path(assigns(:list))
  end

  test "should show list" do
    get :show, id: @list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @list
    assert_response :success
  end

  test "should update list" do
    patch :update, id: @list, list: { accountant_id: @list.accountant_id, member_one: @list.member_one, member_three: @list.member_three, member_two: @list.member_two, president_id: @list.president_id, secretary_id: @list.secretary_id, selection_id: @list.selection_id, vice_president_id: @list.vice_president_id, vote_count: @list.vote_count }
    assert_redirected_to list_path(assigns(:list))
  end

  test "should destroy list" do
    assert_difference('List.count', -1) do
      delete :destroy, id: @list
    end

    assert_redirected_to lists_path
  end
end
