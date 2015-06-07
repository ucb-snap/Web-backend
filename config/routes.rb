Rails.application.routes.draw do
  # '/'
  get '/' => 'user#index'

  # '/user/'
  devise_for :users
  resources :user
  # '/user/projects/'
  get '/user/:id/projects' => 'project#index', as: 'user_projects'
  # '/user/courses/'
  get '/user/:id/courses/teaching' => 'course#taught', :as => :taught_courses
  get '/user/:id/courses/enrolled' => 'course#enrolled', :as => :enrolled_courses
  get '/user/:id/courses/all' => 'course#all_courses', :as => :all_courses
  # '/user/conversation/'
  get '/user/:id/conversations' => 'message#conversations', as: 'conversations'
  get '/user/:id/conversations/:conversation_id/messages' => 'message#messages', as: 'messages'
  get '/user/:id/conversations/new'=> 'message#new_message', as: 'new_message'
  post '/user/:id/conversations/:conversation_id/messages/', to: 'message#reply', as: 'reply'
  post '/user/:id/conversations/new', to: 'message#create_new_message', as: 'create_message'
  delete '/user/:id/conversations/:conversation_id' => 'message#destroy', as: 'delete_message'

  # '/projects/'
  resources :project
  post '/project/:id', to: 'project#comment', as: 'project_comment'

  # '/course/'
  resources :course do
    resources :assignment
  end
  post '/course/:id/enroll' => 'course#enroll', :as => :course_enroll
  post '/course/:id/unenroll' => 'course#unenroll', :as => :course_unenroll
  # get '/course/:id/assignments/:assignment_id' => 'assignment#show', as: 'show_assignment'
  # get '/course/:id/assignments/new' => 'assignment#new', as: 'new_assignment'
  # post '/course/:id/assignments/new', to: 'assignment#create', as: 'create_assignment'
  post '/course/:id/assignments/:assignment_id' => 'assignment#submit', as: 'submit_assignment'
end
