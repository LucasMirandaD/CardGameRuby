Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :players, param: :nickname, only: %i[update destroy new edit] do
    member do
      post :login # /players/:nickname/login
    end
  end

  resources :boards, only: %i[update destroy new edit] do
  end

  # ROUTES
  # Prefix Verb  URI    Pattern                                                                                       Controller#Action
  # login_player POST   /players/:nickname/login(.:format)                                                                players#login
  #   new_player GET    /players/new(.:format)                                                                            players#new
  #  edit_player GET    /players/:nickname/edit(.:format)                                                                 players#edit
  #       player PATCH  /players/:nickname(.:format)                                                                      players#update
  #              PUT    /players/:nickname(.:format)                                                                      players#update
  #              DELETE /players/:nickname(.:format)                                                                      players#destroy
  #    new_board GET    /boards/new(.:format)                                                                             boards#new
  #   edit_board GET    /boards/:id/edit(.:format)                                                                        boards#edit
  #        board PATCH  /boards/:id(.:format)                                                                             boards#update
  #              PUT    /boards/:id(.:format)                                                                             boards#update
end
