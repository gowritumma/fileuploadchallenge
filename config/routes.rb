Rails.application.routes.draw do
 
  get 'counties/search'

  resources :uploads
  get 'counties/search', to: "counties#search"
  get 'counties/get_results', to: "counties#get_results"
  get 'counties/states_info', to: "counties#states_info"
  get 'counties/get_counties_for_statename', to: "counties#get_counties_for_statename"
  get '/uploads/download/:id', to: 'uploads#download', as: "download"
  get 'search_state/:q' => 'counties#search_state'
  # get 'get_counties_for_statename/:state' => 'counties#get_counties_for_statename'
  post '/uploads', to: "uploads#create"
  # get '/uploads', to: "uploads#index"
  # get 'uploads/new', to: 'uploads#new'
  get 'counties/get_counties_for_stateId/', to: "counties#get_counties_for_stateId", as: "counties_for_state"
  devise_for :users
  devise_scope :user do
   get "signup", to: "devise/registrations#new"
   get "login", to: "devise/sessions#new"
   get "logout", to: "devise/sessions#destroy"

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "welcome#index"

   # API routes
  namespace :api do
    namespace :v1 do
      # resources :sessions, :only => [:create, :destroy]
		get 'counties/get_counties_with_zip(/:zip)', to: "counties#get_counties_with_zip"
		get 'counties/get_counties_states_abbr(/:abbr)', to: "counties#get_counties_states_abbr"
 	end
 end

end
