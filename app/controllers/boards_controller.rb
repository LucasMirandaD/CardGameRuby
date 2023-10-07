class BoardsController < ApplicationController
  include SessionHelper
  before_action :check_token, only: %i[create join save_result] # puedo recuperar el jugador
  before_action :set_game, only: %i[create join save_result]

  def index
    board = Board.all
    render json: { boards: board }, status: :ok
  end

  def show
    board = Board.find_by(id: params[:id])

    if board.present?
      render json: { board: board }, status: :ok
    else
      render json: { message: "no se encuentra el tablero #{params[:board_name]}" }, status: :unprocessable_entity
    end
  end

  def create
    player1 = Player.find_by(id: params[:player_nickname])
    board = Board.create(board_name: params[:board_name], player1: player1)

    if board.save?
      render json: { board: board }, status: :ok
    else
      render json: { message: board.errors.details }, status: :unprocessable_entity
    end
  end

  def update
    update_board
  end

#   def join
#     @board.player2 = player

#     if board.persisted?
#       render status: 200, json: { board: board }
#     else
#       render status: 400, json: { message: board.errors.details }
#     end
#   end

#   def destroy
#     @board = Board.find_by(id: params[:id])
#     if @board.present?
#       @board.destroy
#       render status: 200, json: { message: "Se destruyo el tablero #{params[:id]}" }
#     else
#       render status: 404, json: { message: "No se encuentra el tablero #{params[:id]}" }
#     end
#   end

  def save_result
    return render status: 400, json: { message: "El juego ya ha terminado!" } if @board.winner != 0 # No me deja jugar si ya hay un ganador
    return render status: 400, json: { message: "No es tu partida!" } if @player != @board.player1 && @player != @board.player2  # No deja jugar un player que no pertenece al game

    @board.result = params[:result]
    @board.turn = @board.turn+1 # Incremento el turno en 1, porque marcar una celda representa un turno

    @board.winner_game # Llamo al método de instancia para ver si uno de los dos jugadores gana la partida

    game_save
  end

  private

  def update_board
    board = Board.find_by(id: params[:id])
    if board.present?
      if board.update(board_params)
        render json: { board: board }, status: :ok
      else
        render json: { message: board.errors.details }, status: :unprocessable_entity
      end
    else
      render status: 404, json: { message: "No se encuentra el tablero #{params[:id]}" }
    end
  end

  def board_params
    params.permit(:winner, :player_1, :player_2, :board_name)
  end
end
