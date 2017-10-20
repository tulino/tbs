require 'test_helper'

class EventCategoriesControllerTest < ActionController::TestCase
  setup do
    @event_category = event_categories(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_categories)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create event_category' do
    assert_difference('EventCategory.count') do
      post :create, params: { event_category: { name: @event_category.name } }
    end

    assert_redirected_to event_category_path(assigns(:event_category))
  end

  test 'should show event_category' do
    get :show, params: { id: @event_category }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @event_category }
    assert_response :success
  end

  test 'should update event_category' do
    patch :update, params: { id: @event_category, event_category: { name: @event_category.name } }
    assert_redirected_to event_category_path(assigns(:event_category))
  end

  test 'should destroy event_category' do
    assert_difference('EventCategory.count', -1) do
      delete :destroy, params: { id: @event_category }
    end

    assert_redirected_to event_categories_path
  end
end
