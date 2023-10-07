class PlayersController < ApplicationController
  include SessionHelper
  before_action :check_token, except: %i[login create] # , only: [ :show,]

  def index
    players = Player.all
    render json: { players: players }, status: :ok
  end

  def show
    @player = Player.find_by(nickname: params[:nickname])

    if @player.present?
      render json: { player: @player }, status: :ok
    else
      render status: 404, json: { message: "no se encuentra el jugador #{params[:nickname]}" }
    end
  end

  def login
    @player = Player.find_by(nickname: params[:nickname], password: params[:password])

    if @player.present?
      render json: { player: @player }, status: :ok
    else
      render json: { message: @player.errors.details }, status: :unprocessable_entity
    end
  end

  def create
    @player = Player.create(player_params)

    if @player.persisted?
      render json: { player: @player }, status: :ok
    else
      render json: { message: @player.errors.details }, status: :unprocessable_entity
    end
  end

  def update
    player = Player.find_by(nickname: params[:nickname])

    if player.present?
      if player.update(player_params)
        render json: { player: @player }, status: :ok
      else
        render status: 400, json: { message: player.errors.details }
      end
    else
      render status: 404, json: { message: "No se encuentra el jugador #{params[:id]}" }
    end
  end

    # def destroy

    #     @player = Player.find_by(nickname: params[:nickname])

    #     if @player.present?
    #         @player.destroy
    #         render status:200 ,json: {message: "Se destruyo el jugador #{params[:id]}"}
    #     else
    #         render status:404 , json: {message: "No se encuentra el jugador #{params[:id]}"}
    #     end
    # end

  private

  def player_params
    params.permit(:name, :lastname, :password, :nickname)
  end
end
