Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :players , param: :nickname , except:[:update, :destroy, :new, :edit] do
    member do
      post :login # /players/:nickname/login
    end
  end
    
    resources :boards , except:[:update, :destroy, :new, :edit] do
  end
=begin
  root "tateti#index"

  get"tateti/players", to: "players#index"
  get"tateti/players/:id", to: "players#show"
  post"tateti/players", to: "players#create"
  post "players/:nickname/login" to: players#login
  patch"tateti/players/:id", to: "players#update"
  delete"tateti/players/:id", to: "players#destroy"
  #no voy a definir el put

  get"/boards", to: "boards#index"
  get"/boards/:id", to: "boards#show"
  post"/boards", to: "boards#create" 
  patch"/boards/:id", to: "boards#update"
  delete"/boards/:id", to: "boards#destroy" 
=end 
end
