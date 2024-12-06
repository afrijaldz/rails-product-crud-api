Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      get "/products", to: "products#index", as: "products"
      get "/products/paginate", to: "products#paginate", as: "product_paginate"
      get "/products/:id", to: "products#show", as: "post"
      post "/products", to: "products#create"
      get "/products/:id/edit", to: "products#update", as: "edit_post"
      delete "/products/:id", to: "products#destroy"
    end
  end
end
