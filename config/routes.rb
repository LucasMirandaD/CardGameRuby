Rails.application.routes.draw do
   resource :player, only: %i[] do
     post :login
   end
   resources :players, only: %i[create update destroy] do
     put :update_image
   end

   resources :boards, only: %i[index show create update destroy] do
     post :join_board
   end

   resource :board, only: %i[] do
     post :deal_cards
     post :take_card
     post :throw_card
   end
 end