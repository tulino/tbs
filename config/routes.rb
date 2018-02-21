Rails.application.routes.draw do
  resources :decisions

  resources :black_lists, except: [:show] do
    get 'change_approve_status', on: :member
  end
  get 'event_response/create'

  get 'event_response/destroy'

  post 'event_response/create'

  post 'event_response/destroy'

  resources :events do
    get 'event_responses', on: :member, defaults: {format: :json}
    get 'all_events', on: :collection
    get 'pending_events', on: :collection
    get 'past_events', on: :collection
    get 'club_events', on: :collection
    get 'clubs_of_member_events', on: :collection
  end
  resources :event_locations
  resources :event_categories
  resources :club_slides
  resources :academic_periods
  resources :role_types
  resources :roles_users
  devise_for :users,:controllers => { sessions: "sessions", registrations: 'registrations'}
  resources :profiles,  only: [:show, :update]
  resources :roles
  resources :club_contacts
  resources :club_settings
  resources :club_board_of_directors
  resources :club_board_of_supervisories
  resources :assistant_consultants
  resources :club_periods do |variable|
    get 'member_list', on: :member, defaults: {format: :json}
    get 'edit_member_list', on: :member
    get 'change_member_status', on: :member
    get 'member_destroy', on: :member
    get 'club_type', on: :member, defaults: {format: :json}
  end
  resources :announcements
  resources :system_announcements
  resources :clubs do
    get 'pending_users', on: :member
    get 'club_users', on: :member
  end
  resources :faculties
  resources :club_categories
  get 'all_pending_users' => 'clubs#all_pending_users'
  get 'status_edit' => 'roles#status_edit'
  get 'find_ogrenci' =>'users#find_ogrenci'
  get 'find_personel' =>'users#find_personel'
  get 'download_events' => 'events#download_events'
  root 'clubs#index'
  get 'membership_status' => 'roles#membership_status'
end
