RailsFrance::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  # Root
  root :to => "home#index"

  # Devise
  devise_for :users, :path => 'compte', 
    :path_names => { :sign_in => 'connexion', :sign_out => 'deconnexion', 
      :sign_up => 'inscription', :password => 'mot-de-passe' }

  # User
  resources :membres, :controller => :users, :as => :users, :only => [:index, :show]

  match 'preview' => 'content#preview'

  # Map
  resources :map, :only => [:index] do
    collection do
      get :users
      get :jobs
      get :events
    end
  end

  # Jobs
  resources :jobs do
    collection do
      get :preview
      get :confirm
    end
  end

  match '/jobs/validate/:token' => 'jobs#validate', :as => 'validate_job'
  match '/jobs/edit/:token' => 'jobs#edit', :as => 'edit_job'

  # Questions & Answers
  resources :questions do
    get :vote, :on => :member
    get :autocomplete_tag_name, :on => :collection
    resources :answers, :only => [:create] do
      get :vote, :on => :member
      get :accept, :on => :member
    end
  end

  # Tags
  resources :tags, :only => [:index]

  # Events
  resources :evenements, :controller => :events, :as => :events do
    get :attend, :on => :member
    get :unattend, :on => :member
    resources :comments, :only => [:create]
  end

  # Resources
  resources :ressources, :controller => :resources, :as => :resources, :only => [:index]

  # Contacts
  resources :contacts do
    post :send_email, :on => :collection
  end
end
