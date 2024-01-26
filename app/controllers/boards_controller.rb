class BoardsController < ApplicationController
  include SessionHelper
  include CardEnum
  before_action :check_token # puedo recuperar el jugador
  before_action :find_board, :check_winner, only: %i[join_board take_card deal_cards game_over]

  def index
    board = Board.all
    render json: { boards: board }, status: :ok
  end

  def show
    board = Board.find(params[:id])
    render json: { board: board, deck: board.deck }, status: :ok
  end

  def create
    player1 = Player.find(params[:board][:player1_id])
    board_deck = Deck.create(content: CardEnum::CARD_ENUM_VALUES.dup.shuffle)
    board = Board.new(board_name: params[:board][:board_name],
                      player1_id: player1.id,
                      deck_id: board_deck.id)
    board.deck = board_deck
    player1.deck = Deck.create
    player1.deck.board_id = board.id

    if board.save
      render json: { board: board }, status: :ok
    else
      render json: { message: board.errors.details }, status: :unprocessable_entity
    end
  end

  def destroy
    board = Board.find(params[:id])

    if board.destroy
      render json: { message: "Se destruyo el tablero #{params[:id]}" }, status: :ok
    else
      render status: :unprocessable_entity
    end
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
    player2 = Player.find(params[:board][:player2_id])
    player2.deck = Deck.create
    player2.deck.board_id = @board.id

    if @board.player2.present?
      render json: { message: 'La partida está completa' }, status: :unprocessable_entity
    else
      @board.update(player2: player2)
      render json: { message: 'Te has unido a la partida exitosamente' }, status: :ok
    end
  end

  def take_card
    player = Player.find(params[:board][:player_id])
    player.deck.content << @board.deck.content.shift # saca el primer elemento

    if @board.deck.save && player.deck.save
      render json: { message: player.deck.content.last }, status: :ok
      # render json: { player_deck: player.deck, board_deck: board.deck }, status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def throw_card
    player = Player.find(params[:board][:player_id])
    card = params[:board][:card_url]
    thrown_card = player.deck.content.reject! { |element| element == card }
    # delete_if funciona igual que reject! pero no devuelve true o false

    if thrown_card && player.deck.save
      render json: { message: card }, status: :ok
      # render json: { message: "La carta '#{card}' ha sido lanzada correctamente.", cartas: player.deck.content }, status: :ok
    else
      render json: { message: "El jugador no posee la carta '#{card}'." }, status: :unprocessable_entity
    end
  end

  def deal_cards
    cards_per_player = 7 # podria ser ingresado por los usuarios

    player1 = Player.find(@board.player1_id)
    player2 = Player.find(@board.player2_id)

    player1.deck.content += @board.deck.content.shift(cards_per_player) # += por que son 2 arrays y sino no funciona
    player2.deck.content += @board.deck.content.shift(cards_per_player)

    if player1.deck.save && player2.deck.save && @board.deck.save
      # render json: { player1_deck: player1.deck, player2_deck: player2.deck, board_deck: board.deck }, status: :ok
      render status: :ok, json: { message: [player1.deck.content, player2.deck.content] }
    else
      render status: :unprocessable_entity
    end
  end

  def game_over
    winner = Player.find(params[:board][:winner_id])
    if @board.update(winner: winner)
      render json: { message: winner }, status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  private

  def find_board
    @board = Board.find(params[:board][:id])
  end

  def check_winner
    return unless @board.winner.nil?

    render json: { message: 'Este juego ya terminó' }
  end

  def board_params
    params.require(:board).permit(:winner, :player1, :player2, :board_name)
  end
end
