class PlayersController < ApplicationController
  include SessionHelper
  before_action :check_token, except: %i[login create]

  PLAYER_TO_JSON = { include: { image: { methods: :full_url } } }.freeze

  def index
    players = Player.all
    render json: { players: players }, status: :ok
  end

  def show
    player = Player.find(params[:id])
    render json: { player: player }, status: :ok
  end

  def login
    player = Player.find_by('(email = :email OR nickname = :nickname) AND password = :password',
                            { email: params[:player][:email],
                              nickname: params[:player][:nickname],
                              password: params[:player][:password] })
    if player.present?
      token = player.token if player.token.present?
      response.headers['Authorization'] = "Bearer #{token}"
      render json: {}, status: :ok
    else
      render json: { message: player.errors.details }, status: :unprocessable_entity
    end
  end

  def create
    player = Player.new(player_params)

    if player.save
      render json: { player: player }, status: :ok
    else
      render json: { message: player.errors.details }, status: :unprocessable_entity
    end
  end

  def update
    player = Player.find(params[:id])

    if player.update(player_params)
      render json: { player: player }, status: :ok
    else
      render json: { message: player.errors.details }, status: :unprocessable_entity
    end
  end

  def destroy
    player = Player.find(params[:id])
    if player.destroy
      head :no_content, status: :ok
    else
      render json: { message: player.errors.details }, status: :unprocessable_entity
    end
  end

  def update_image
    player = Player.find(params[:player_id])

    if player.image.present? && params[:image].present?
      player.image.file.purge
      player.image.file.attach(params[:image])
    else
      player.image = Image.new(file: params[:image]) if params[:image].present?
    end

    if player.save
      render json: player.as_json(PLAYER_TO_JSON), status: :ok
    else
      render json: { message: player.errors.details }, status: :unprocessable_entity
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :password, :nickname, :email)
  end
end
