class PlayersController < ApplicationController
  include SessionHelper
  before_action :check_token, except: %i[login create]

  PLAYER_TO_JSON = { only: %i[id token] }.freeze

  def index
    players = Player.all
    render json: { players: players }, status: :ok
  end

  def show
    player = Player.find(params[:id])
    deck = player.deck.present? ? player.deck.content : ''
    image_url = player.image.present? ? url_for(player.image) : ''

    render json: { player: player, image_url: image_url, deck: deck }, status: :ok
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

    # Imagen por defecto para el player
    player.image.attach(io: File.open(Rails.root.join('public', 'images', 'null_profile.png')),
                        filename: 'null_profile.png',
                        content_type: 'image/png')

    if player.save && player.image.save
      token = player.token if player.token.present?
      response.headers['Authorization'] = "Bearer #{token}"
      render json: { data: player.to_json(PLAYER_TO_JSON), image_url: url_for(player.image) }, status: :ok
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
    player.image.purge if player.image.attached?

    if player.destroy
      head :no_content, status: :ok
    else
      render json: { message: player.errors.details }, status: :unprocessable_entity
    end
  end

  def update_image
    player = Player.find(params[:player_id])
    image_params = params[:image]

    if player.image.present? && params[:image].present?
      player.image.purge # Elimina el archivo adjunto existente
    end

    player.image.attach(image_params)

    if player.save
      render json: { data: player.as_json(PLAYER_TO_JSON), image_url: url_for(player.image) }, status: :ok
    else
      render json: { message: player.errors.details }, status: :unprocessable_entity
    end
  end

  def cards_count
    # Esto tendria que ser un metodo de instancia en el modelo
    player = Player.find(params[:player_id])
    render json: { count: player.deck.content.count }
  end

  def cards
    # Esto tendria que ser un metodo de instancia en el modelo
    player = Player.find(params[:player_id])
    render json: { cards: player.deck.content }
  end

  private

  def player_params
    params.require(:player).permit(:name, :password, :nickname, :email, :image)
  end
end
