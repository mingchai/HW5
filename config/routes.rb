Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :comments, only:[:create, :destroy]
    # nested to create and enforce relationship between the tables. This way, the foreign key is passed in the params too.
    # when creating or destroying comments, they will add or delete a specific comment belonging to a specific post
  end

  resources :users, only: [:new, :create, :edit, :update]
  get("/users/:id/change_password", to: "users#edit_password", as: :edit_password)
  patch("/users/:id/change_password", to: "users#update_password", as: :change_password)
  put("/users/:id/change_password", to: "users#update_password")
  post("/users/:id/change_password", to: "users#update_password")


  resource :session, only:[:new, :create, :destroy]

  get("/", to:"posts#index", as: :root)

  
end
