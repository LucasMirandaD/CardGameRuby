class BoardsController < ApplicationController
  include SessionHelper
  include CardEnum
  before_action :check_token, only: %i[create join save_result] # puedo recuperar el jugador
  before_action :initialize_deck, only: [:create, :deal_cards]

  def index
    board = Board.all
    render json: { boards: board }, status: :ok
  end

  def show
    board = Board.find(params[:id])
    render json: { board: board }, status: :ok
  end

  def create
    @player1 = Player.find(params[:board][:player1_id])
    board = Board.new(board_name: params[:board][:board_name], player1_id: @player1.id)

    if board.save
      render json: { board: board }, status: :ok
    else
      render json: { message: board.errors.details }, status: :unprocessable_entity
    end
  end

  def destroy
    board = Board.find(params[:id])
    board.destroy
    render status: ok, json: { message: "Se destruyo el tablero #{params[:id]}" }
  end

  def update
    board = Board.find(params[:id])
    if board.update(board_params)
      render json: { board: board }, status: :ok
    else
      render json: { message: board.errors.details }, status: :unprocessable_entity
    end
  end

  def join_board
    @player2 = Player.find(params[:board][:player2_id])
    board = Board.find(params[:board_id])

    if board.player2.present?
      render json: { message: 'La partida está completa' }, status: :unprocessable_entity
    else
      board.update(player2: @player2)
      render json: { message: 'Te has unido a la partida exitosamente' }, status: :ok
    end
  end

  def take_card
    # cambiar para que el mazo sea de la partida
    # declarar cards y agregar el modelo card
    player = Player.find(params[:board][:player_id])
    player.cards.create(deck.shift) # saca el primer elemento
    render status: :ok
  end

  def throw_card
    player = Player.find(params[:player_id])
    card_name = params[:card_name]

    if player.cards.exists?(card: card_name)
      # Encuentra la carta en posesión del jugador y la elimina
      thrown_card = player.cards.find_by(card: card_name)
      thrown_card.destroy
      render json: { message: "La carta '#{card_name}' ha sido lanzada correctamente." }, status: :ok
    else
      render json: { message: "El jugador no posee la carta '#{card_name}'." }, status: :unprocessable_entity
    end
  end

  def deal_cards
    cards_per_player = 7 # podria ser ingresado por los usuarios

    player1_cards = deck.slice!(0, cards_per_player)
    player2_cards = deck.slice!(0, cards_per_player)

    assign_cards_to_player(player1, player1_cards)
    assign_cards_to_player(player2, player2_cards)

    render status: :ok, json: { message: [player1_cards, player2_cards] }
  end

  private

  def board_params
    params.require(:board).permit(:winner, :player1, :player2, :board_name)
  end

  def initialize_deck
    @deck = CardEnum::CARD_ENUM_VALUES.dup.shuffle # Baraja todas las cartas y las guarda en un mazo
  end

  def assign_cards_to_player(player, player_cards)
    player_cards.each do |player_card|
      player.cards.create(card: player_card)
    end
  end
end
