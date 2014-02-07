Rcms::Application.routes.draw do
  devise_for :users
  resources :settings,:path => ":role/settings/" do
    member do
      get :change_password
      put :update_password
    end
  end
  
  resources :notes
  namespace :client do
    resources :intakes
    resources :dashboards
    resources :individuals do
      member do
        get :medical
        post :medical_information
        get :personal
        post :personal_information
        get :minor
        post :minor_information
      end
    end
    resources :partners,:only => [:new,:create] do
      collection do
        get :partners_family
        post :partners_family_create
      end
    end
    resources :minors do
      member do
        get :medical
        post :medical_information
        get :personal
        post :personal_information
      end
    end
    resources :financials
    resources :career_assessments,:only => [:new,:create]
    resources :reduced_fees,:only => [:new,:create]
    resources :renewal_groups
  end
  
  namespace :counselor do
    resources :dashboards
  end

  namespace :intake_coordinator do
    resources :dashboards do
      member do
        get :intake_details
        get :details
      end
      collection do
        post :assign_case_counselor
        get :calendar
      end
    end
    resources :cases do
      collection do 
        get :search_cases
        get :case_list
        post :assign_case
      end
    end
  end
  
  namespace :admin do
    resources :case_prefixes
    resources :users do
      collection do
        get :clients
        get :search_clients
      end
      member do
        put :change_status
      end
    end
    resources :cpt_codes
    resources :misc_payments
    resources :dashboards
    resources :rooms do
      member do
        put :change_status
      end
    end
    resources :forms
    resources :payers do
      collection do
        get :search_payers
      end
    end
  end
  
  namespace :clinical_supervisor do
    resources :dashboards
  end
  
  namespace :clinical_director do
    resources :dashboards
  end
  
  namespace :admin_director do
    resources :dashboards
  end
  
  namespace :accounting_manager do
    resources :dashboards
  end
  
  namespace :reports_manager do
    resources :dashboards
  end
  
  namespace :scheduling_manager do
    resources :dashboards
  end
  
  resources :client_managements,:path => "/:role/client_managements" do
    member do
      post :upload_document
    end
  end
  resources :case_managements,:path => "/:role/case_managements"
  resources :reminders,:path => "/:role/reminders"
  resources :documents,:path => "/:role/documents"
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
