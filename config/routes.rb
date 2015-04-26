Rails.application.routes.draw do
  devise_for :users
  get '/' => 'user#index'
  get '/user/:id/projects' => 'user#projects', as: 'user_projects'
  get '/user/:id/conversations' => 'user#conversations', as: 'conversations'
  get '/user/:id/conversations/:conversation_id/messages' => 'user#messages', as: 'messages'
  #post '/user/:id/conversations/:conversation_id', to: 'user#post_message', as: 'send_message'

  get '/user/:id/conversations/new'=> 'user#new_message', as: 'new_message'
  post '/user/:id/conversations/:conversation_id/messages/', to: 'user#reply', as: 'reply'
  post '/user/:id/conversations/new', to: 'user#create_new_message', as: 'create_message'

  delete '/user/:id/conversations/:conversation_id' => 'user#destroy', as: 'delete_message'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  resources :user
  resources :project
  resources :course
  resources :snapassignments

  get 'user/:id/courses/teaching' => 'user#taught', :as => :taught_courses
  get 'user/:id/courses/enrolled' => 'user#enrolled', :as => :enrolled_courses
  get 'user/:id/courses/all' => 'user#all_courses', :as => :all_courses
  post 'course/:id/enroll' => 'snapclass#enroll', :as => :course_enroll
  post 'course/:id/unenroll' => 'course#unenroll', :as => :course_unenroll
  post '/project/:id', to: 'project#comment', as: 'project_comment'
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
