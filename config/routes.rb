ActionController::Routing::Routes.draw do |map|
  map.resources :stats
  map.root :controller => :stats
  Jammit::Routes.draw(map)
  
end
