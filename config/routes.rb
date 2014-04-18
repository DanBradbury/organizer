Organizer::Application.routes.draw do
  root 'welcome#index'

  resources :site_managers

  post '/site_managers/find_image' => 'site_managers#find_image'

  get '/search_images' => 'site_managers#search_images', as: :search_images

  post '/move_item' => 'site_managers#move_item', as: :move_item
end
