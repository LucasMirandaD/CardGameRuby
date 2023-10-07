module SessionHelper
  def check_token
    token = request.headers['Authorization'].split(' ') # Para el token quitando el bearer
    player = Player.find_by(token: token[1]) # En token[0] queda "Bearer"

    return if player.present?

    render json: { message: 'Debe iniciar sesión con un usuario válido' }, status: 401
  end
end
