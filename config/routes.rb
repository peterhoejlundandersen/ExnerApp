Rails.application.routes.draw do

  resources :works
  #For at vise den kategory
  get ':category' => 'works#category_show', as: 'category'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
