ActionController::Routing::Routes.draw do |map|
  map.resources :stats
  map.resources :search
  map.root :controller => :stats
  Jammit::Routes.draw(map)
  
end
