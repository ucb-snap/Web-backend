Rails.application.routes.draw do
  devise_for :snapusers
  get '/' => 'snapuser#index'
  get '/snapuser/:id/projects' => 'snapuser#projects', as: 'snapuser_projects'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  resources :snapuser
  resources :snapproject
  resources :snapclass
  resources :snapassignments
<<<<<<< HEAD

  get 'snapuser/:id/classes/teaching' => 'snapuser#taught', :as => :taught_classes
  get 'snapuser/:id/classes/enrolled' => 'snapuser#enrolled', :as => :enrolled_classes
  get 'snapuser/:id/classes/all' => 'snapuser#all_classes', :as => :all_classes
  post 'classes/:id/enroll' => 'snapclass#enroll', :as => :snapclass_enroll
  post 'classes/:id/unenroll' => 'snapclass#unenroll', :as => :snapclass_unenroll
=======
  post '/snapproject/:id', to: 'snapproject#comment', as: 'snapproject_comment'
>>>>>>> master
  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
