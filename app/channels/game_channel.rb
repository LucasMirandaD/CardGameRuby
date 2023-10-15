class GameChannel < ApplicationCable::Channel
  def subscribed
    # Se suscribe a un canal específico cuando un jugador se conecta
    stream_from "game_#{params[:game_id]}" # mismo uuid del board
  end

  def receive(data)
    # Procesa los mensajes recibidos del cliente
    ActionCable.server.broadcast("game_#{params[:game_id]}", data) # hago un broadcast con la carta que tira a la mesa
  end

  def unsubscribed
    # Se desuscribe del canal cuando un jugador se desconecta
  end
end
