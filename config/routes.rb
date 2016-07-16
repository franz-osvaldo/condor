Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :aircrafts do
    resources :systems, shallow: true
  end
  resources :systems, only: [] do
    resources :components, shallow: true
  end
end
