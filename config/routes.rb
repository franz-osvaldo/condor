Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :aircrafts do
    resources :systems, shallow: true
  end
  resources :systems, only: [] do
    resources :components, shallow: true
  end
  resources :systems, only: [] do
    resources :scheduled_inspections, shallow: true
  end
  resources :components, only: [] do
    resources :parts, shallow: true
  end
  resources :fleets do
    collection do
      get 'aircrafts'
    end
    resources :flights, shallow: true
  end
  resources :product_units
  resources :products
  resources :suppliers
  resources :incoming_movement_types
  resources :incoming_movements do
    member do
      get 'new_field'
    end
    collection do
      get 'get_products'
    end
  end
  resources :receivers
  resources :outgoing_movement_types
  resources :outgoing_movements do
    member do
      get 'new_field'
    end
    collection do
      get 'get_products'
    end
  end

  resources :tools

end



