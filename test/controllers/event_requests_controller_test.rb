require 'test_helper'

class EventRequestsControllerTest < ActionController::TestCase
  setup do
    @event_request = event_requests(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_requests)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create event_request' do
    assert_difference('EventRequest.count') do
      post :create, params: { event_request: { category_id: @event_request.category_id, content: @event_request.content, datetime: @event_request.datetime, period_id: @event_request.period_id, is_advisor_confirmation: @event_request.is_advisor_confirmation, locations: @event_request.locations, service_and_materials: @event_request.service_and_materials, speakers: @event_request.speakers, title: @event_request.title } }
    end

    assert_redirected_to event_request_path(assigns(:event_request))
  end

  test 'should show event_request' do
    get :show, params: { id: @event_request }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @event_request }
    assert_response :success
  end

  test 'should update event_request' do
    patch :update, params: { id: @event_request, event_request: { category_id: @event_request.category_id, content: @event_request.content, datetime: @event_request.datetime, period_id: @event_request.period_id, is_advisor_confirmation: @event_request.is_advisor_confirmation, locations: @event_request.locations, service_and_materials: @event_request.service_and_materials, speakers: @event_request.speakers, title: @event_request.title } }
    assert_redirected_to event_request_path(assigns(:event_request))
  end

  test 'should destroy event_request' do
    assert_difference('EventRequest.count', -1) do
      delete :destroy, params: { id: @event_request }
    end

    assert_redirected_to event_requests_path
  end
end
