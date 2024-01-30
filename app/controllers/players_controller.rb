class PlayersController < ApplicationController
  include SessionHelper
  before_action :check_token, except: %i[login create]

  PLAYER_TO_JSON = {  only: %i[id token],
                      include: { image: { methods: :full_url } } }.freeze

  PLAYER_CREATE_TO_JSON = { only: %i[id token] }.freeze

  PLAYER_LOGIN_TO_JSON = { only: %i[id],
                           include: { image: { methods: :url } } }.freeze

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
      # render json: { id: player.id, token: token, image_url: player.image.image_url }, status: :ok
      render json: { id: player.id, token: token }, status: :ok
    else
      render json: { message: player.errors.details }, status: :unprocessable_entity
    end
  end

  def create
    player = Player.new(player_params)

    # Construir la imagen y asociarla al jugador
    image = player.build_image
    image.file.attach(io: File.open(Rails.root.join('public', 'images', 'null_profile.png')), filename: 'null_profile.png', content_type: 'image/png')

    if player.save
      token = player.token if player.token.present?
      response.headers['Authorization'] = "Bearer #{token}"
      render json: { data: player.to_json(PLAYER_CREATE_TO_JSON), full_image_url: player.image.full_url }, status: :ok
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
    image_params = params[:image]
    if player.image.file.present? && params[:image].present?
      player.image.file.purge # Elimina el archivo adjunto existente
    end
    player.image.file.attach(io: image_params.tempfile, filename: image_params.original_filename) if image_params.present?

    if player.save
      render json: { data: player.as_json(PLAYER_TO_JSON), url_completa: url_for(player.image.file) }, status: :ok
    else
      render json: { message: player.errors.details }, status: :unprocessable_entity
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :password, :nickname, :email, :image)
  end
end
