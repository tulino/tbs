require 'test_helper'

class ClubContactsControllerTest < ActionController::TestCase
  setup do
    @club_contact = club_contacts(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:club_contacts)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create club_contact' do
    assert_difference('ClubContact.count') do
      post :create, params: { club_contact: { address: @club_contact.address, email: @club_contact.email, period_id: @club_contact.period_id, face_url: @club_contact.face_url, github_url: @club_contact.github_url, gplus_url: @club_contact.gplus_url, linkedin_url: @club_contact.linkedin_url, phone_number: @club_contact.phone_number, tw_url: @club_contact.tw_url, youtube_url: @club_contact.youtube_url } }
    end

    assert_redirected_to club_contact_path(assigns(:club_contact))
  end

  test 'should show club_contact' do
    get :show, params: { id: @club_contact }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @club_contact }
    assert_response :success
  end

  test 'should update club_contact' do
    patch :update, params: { id: @club_contact, club_contact: { address: @club_contact.address, email: @club_contact.email, period_id: @club_contact.period_id, face_url: @club_contact.face_url, github_url: @club_contact.github_url, gplus_url: @club_contact.gplus_url, linkedin_url: @club_contact.linkedin_url, phone_number: @club_contact.phone_number, tw_url: @club_contact.tw_url, youtube_url: @club_contact.youtube_url } }
    assert_redirected_to club_contact_path(assigns(:club_contact))
  end

  test 'should destroy club_contact' do
    assert_difference('ClubContact.count', -1) do
      delete :destroy, params: { id: @club_contact }
    end

    assert_redirected_to club_contacts_path
  end
end
