ActionController::Routing::Routes.draw do |map|
  map.resources :statuses, :collection => {
                                            :friends_timeline => :get,
                                            :user_timeline => :get,
                                            :public_timeline => :get,
                                            :replies => :get,
                                            :friends => :get,
                                            :followers => :get
                                          }

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users, :has_many => [:statuses]
  map.resource :session

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.root :controller => "statuses", :action => "friends_timeline"
end
