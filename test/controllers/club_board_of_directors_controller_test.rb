require 'test_helper'

class ClubBoardOfDirectorsControllerTest < ActionController::TestCase
  setup do
    @club_board_of_director = club_board_of_directors(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:club_board_of_directors)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create club_board_of_director' do
    assert_difference('ClubBoardOfDirector.count') do
      post :create, params: { club_board_of_director: { accountant_id: @club_board_of_director.accountant_id, period_id: @club_board_of_director.period_id, member_one: @club_board_of_director.member_one, member_three: @club_board_of_director.member_three, member_two: @club_board_of_director.member_two, president_id: @club_board_of_director.president_id, secretary_id: @club_board_of_director.secretary_id, vice_president_id: @club_board_of_director.vice_president_id } }
    end

    assert_redirected_to club_board_of_director_path(assigns(:club_board_of_director))
  end

  test 'should show club_board_of_director' do
    get :show, params: { id: @club_board_of_director }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @club_board_of_director }
    assert_response :success
  end

  test 'should update club_board_of_director' do
    patch :update, params: { id: @club_board_of_director, club_board_of_director: { accountant_id: @club_board_of_director.accountant_id, period_id: @club_board_of_director.period_id, member_one: @club_board_of_director.member_one, member_three: @club_board_of_director.member_three, member_two: @club_board_of_director.member_two, president_id: @club_board_of_director.president_id, secretary_id: @club_board_of_director.secretary_id, vice_president_id: @club_board_of_director.vice_president_id } }
    assert_redirected_to club_board_of_director_path(assigns(:club_board_of_director))
  end

  test 'should destroy club_board_of_director' do
    assert_difference('ClubBoardOfDirector.count', -1) do
      delete :destroy, params: { id: @club_board_of_director }
    end

    assert_redirected_to club_board_of_directors_path
  end
end
