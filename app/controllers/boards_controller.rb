class BoardsController < ApplicationController
  include SessionHelper
  before_action :check_token, only: %i[create join save_result] # puedo recuperar el jugador

  def index
    board = Board.all
    render json: { boards: board }, status: :ok
  end

  def show
    board = Board.find(params[:id])
    render json: { board: board }, status: :ok
  end

  def create
    player1 = Player.find(params[:board][:player1_id])
    board = Board.new(board_name: params[:board][:board_name], player1_id: player1.id)

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
    player2 = Player.find(params[:board][:player2_id])
    board = Board.find(params[:board][:board_id])

    if board.player2.present?
      render json: { message: 'La partida esta completa' }, status: :unprocessable_entity
    else
      board.player2 = player2
      render status: :ok
    end
  end

  def take_card
  end

  def throw_card
  end

  def deal_cards
  end

  private

  def board_params
    params.require(:board).permit(:winner, :player1, :player2, :board_name)
  end
end
