Rails.application.routes.draw do
   resource :player, only: %i[] do
     get '/:id', to: 'players#show'
     post :login
   end
   resources :players, only: %i[create update destroy] do
     put :update_image
     get :cards_count
     get :cards
   end

   resources :boards, only: %i[index show create update destroy] do
     get :score
     get :shuffle_cards
     post :reset_game
   end

   resource :board, only: %i[] do
     post :deal_cards
     post :take_card
     post :throw_card
     post :join_board
     post :last_card
     post :increase_score
     get 'my_games/:id', to: 'boards#my_games'
     get 'my_games/:id/wins', to: 'boards#wins'
   end
 end