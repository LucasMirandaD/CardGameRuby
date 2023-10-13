Rails.application.routes.draw do
   resource :player, only: %i[] do
     post :login
   end
   resources :players, only: %i[create update destroy]

   resources :boards, only: %i[create update destroy]
 end