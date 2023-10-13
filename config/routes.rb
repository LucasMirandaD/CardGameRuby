Rails.application.routes.draw do
   resource :player, only: %i[] do
     post :login
   end
   resources :players, only: %i[create update destroy] do
     put :update_image
   end

   resources :boards, only: %i[create update destroy]
 end