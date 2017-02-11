Rails.application.routes.draw do
  get '/outbound_routes', to: 'outbound_routes#index', formats: 'json'
  namespace :ivr do
    resources :menus
  end
  namespace :resource do
    resources :records, except: [:new, :create] do
      get :play, on: :member
    end
    post '/record/:freeswitch_id/upload', controller: :records, action: :upload, as: :record_upload
  end
  namespace :callcenter do
    resources :tiers
  end
  namespace :callcenter do
    resources :queues
  end
  get 'help/index'

  get 'cdr/index'
  post 'cdr/index', to: 'cdr#search'
  get 'cdr/:id/play', to: 'cdr#play', as: :cdr_play
  
  resources :endpoint_routes
  resources :extension_groups
  resources :groups
  post 'freeswitch_configurator/configuration', format: :xml
  post 'freeswitch_configurator/dialplan', format: :xml
  post 'freeswitch_configurator/directory', format: :xml
  post 'freeswitch_configurator/json_cdr', format: :json
  get 'dashboard/index'

  resources :destination_profile_actions
  resources :destination_profiles
  resources :extensions
  resources :extension_profile_actions
  resources :extension_profiles
  resources :inbounds
  resources :outbounds
  resources :endpoints
  post '/endpoint/:id/rpc/:cmd', to: 'endpoints#rpc', as: :endpoint_rpc
  devise_for :users
  resources :freeswitches
  root to: 'dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
