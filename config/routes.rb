Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :products
  resources :destinations do
    collection do
      post :assign_route
      get :routed_products
    end
  end

  root 'destinations#routed_products'
end
