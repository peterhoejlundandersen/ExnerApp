Rails.application.routes.draw do
  devise_for :users, path: "", path_names: { sign_in: "inger", sign_up: "opret-bruger" } 
root 'static_pages#index'
  resources :works
  #For at vise den kategory
  # Kan måske bruges
  # get ':category' => 'works#category_show', as: 'category'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
