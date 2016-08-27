Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :aircrafts do
    resources :systems, shallow: true
    collection do
      get 'list'
    end
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
      get 'scheduled_inspections'
      post 'get_graph'
    end
    member do
      get 'get_systems'
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
  resources :outgoing_tool_types
  resources :incoming_tool_types
  resources :incoming_tools do
    collection do
      get 'get_incoming_tools'
    end
    member do
      get 'get_incoming_tool_field'
    end
  end
  resources :outgoing_tools do
    collection do
      get 'get_outgoing_tools'
    end
    member do
      get 'get_outgoing_tool_field'
    end
  end
  resources :borrowed_tools do
    collection do
      get 'get_tools'
    end
    member do
      get 'new_field'
    end
  end
  resources :returned_tools do
    member do
      get 'get_borrowed_tools'
    end
  end
  resources :tool_quantities, only: [] do
    collection do
      get 'assets'
      get 'loaned_tools_list'
      get 'history_report'
      get 'get_custodians'
    end
    member do
      get 'user_history'
    end
  end
  resources :systems, only: [] do
    resources :tasks, shallow: true do
      member do
        get 'new_field'
        get 'new_product_field'
      end
    end
  end
  resources :inspections
end




