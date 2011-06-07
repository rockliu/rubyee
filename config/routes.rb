ActionController::Routing::Routes.draw do |map|
  map.resources :comments

  map.resources :entries

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  #页面REST资源
  map.resources :pages
  #博客REST资源
  map.resources :blogs
  #用户角色嵌套资源
  map.resources :users,:member => { :enable => :put } do |users|
    users.resources :roles
    users.resources :entries do |entry|
      entry.resources :comments
    end
  end
  #文章资源
  map.resources :articles,:collection => {:admin => :get }
  #文章分类嵌套资源
  map.resources :categories,:collection => {:admin => :get } do |categories|
    categories.resources :articles, :name_prefix => 'category_'
  end
  #论坛讨论区,主题,帖子嵌套资源
  map.resources :forums do |forum|
    forum.resources :topics do |topic|
      topic.resources :posts
    end
  end
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  #map.index '/',:controller => 'pages',
  #              :action => 'show',
  #              :id => '1-欢迎页面'
  map.index '/',:controller => 'pages',
                :action => 'show_index'
  map.show_user '/user/:username',
                :controller => 'users',
                :action => 'show_by_username'
                
end
