Rails.application.routes.draw do
   resource :player, only: %i[] do
     get '/:id', to: 'players#show'
     post :login
   end
   resources :players, only: %i[create update destroy] do
     put :update_image
   end

   resources :boards, only: %i[index show create update destroy] do
   end

   resource :board, only: %i[] do
     post :deal_cards
     post :take_card
     post :throw_card
     post :join_board
     get 'my_games/:id', to: 'boards#my_games'
   end
 end