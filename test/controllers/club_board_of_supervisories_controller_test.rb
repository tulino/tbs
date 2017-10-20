require 'test_helper'

class ClubBoardOfSupervisoriesControllerTest < ActionController::TestCase
  setup do
    @club_board_of_supervisory = club_board_of_supervisories(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:club_board_of_supervisories)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create club_board_of_supervisory' do
    assert_difference('ClubBoardOfSupervisory.count') do
      post :create, params: { club_board_of_supervisory: { period_id: @club_board_of_supervisory.period_id, principal_member_one: @club_board_of_supervisory.principal_member_one, principal_member_three: @club_board_of_supervisory.principal_member_three, principal_member_two: @club_board_of_supervisory.principal_member_two, reserve_member_one: @club_board_of_supervisory.reserve_member_one, reserve_member_three: @club_board_of_supervisory.reserve_member_three, reserve_member_two: @club_board_of_supervisory.reserve_member_two } }
    end

    assert_redirected_to club_board_of_supervisory_path(assigns(:club_board_of_supervisory))
  end

  test 'should show club_board_of_supervisory' do
    get :show, params: { id: @club_board_of_supervisory }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @club_board_of_supervisory }
    assert_response :success
  end

  test 'should update club_board_of_supervisory' do
    patch :update, params: { id: @club_board_of_supervisory, club_board_of_supervisory: { period_id: @club_board_of_supervisory.period_id, principal_member_one: @club_board_of_supervisory.principal_member_one, principal_member_three: @club_board_of_supervisory.principal_member_three, principal_member_two: @club_board_of_supervisory.principal_member_two, reserve_member_one: @club_board_of_supervisory.reserve_member_one, reserve_member_three: @club_board_of_supervisory.reserve_member_three, reserve_member_two: @club_board_of_supervisory.reserve_member_two } }
    assert_redirected_to club_board_of_supervisory_path(assigns(:club_board_of_supervisory))
  end

  test 'should destroy club_board_of_supervisory' do
    assert_difference('ClubBoardOfSupervisory.count', -1) do
      delete :destroy, params: { id: @club_board_of_supervisory }
    end

    assert_redirected_to club_board_of_supervisories_path
  end
end
