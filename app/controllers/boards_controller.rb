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
    render status: 200, json: { message: "Se destruyo el tablero #{params[:id]}" }
  end

  def update
    board = Board.find(params[:id])
    if board.update(board_params)
      render json: { board: board }, status: :ok
    else
      render json: { message: board.errors.details }, status: :unprocessable_entity
    end
  end

  private

  def board_params
    params.require(:board).permit(:winner, :player1, :player2, :board_name)
  end
end
