class BoardsController < ApplicationController
    
    before_action :check_token, only:[ :create, :join, :save_result] #check_token me permite recuperar el jugador que está ejecutando la request
    before_action :set_game, only:[ :show, :join, :save_result]
    
    def index
            @boards = Board.all
            render status:200 ,json: {boards: @boards}
    end
    
    def show
        @board = Board.find_by(id: params[:id])
        
        if @board.present?
            render status:200 ,json: {board: @board}
        else
            render status:404 , json: {message: "no se encuentra el tablero #{params[:board_name]}"}
        end
    end


    def create #poner privadas las funciones

        board  = Board.create(board_name: params[:board_name], player_1: Player.find_by(id: params[:player_nickname])) 
        
        if board.persisted?
            render status:200 ,json: {board: board}
        else 
            render status:400, json: {message: board.errors.details}
        end
    end

    def update
        update_board
    end

    # def join
    #     @board.player2 = player
        
    #     if board.persisted?
    #         render status:200 ,json: {board: board}
    #     else 
    #         render status:400, json: {message: board.errors.details}
    #     end
    # end

    # def destroy
    #     @board = Board.find_by(id: params[:id])
    #     if @board.present? 
    #         @board.destroy
    #         render status:200 ,json: {message: "Se destruyo el tablero #{params[:id]}"}
    #     else
    #         render status:404 , json: {message: "No se encuentra el tablero #{params[:id]}"}
    #     end
    # end


    def save_result
        
        return render status: 400, json: {message: "El juego ya ha terminado!"} if @board.winner!=0 #No me deja jugar si ya hay un ganador
        return render status: 400, json: {message: "No es tu partida!"} if @player != @board.player1 && @player != @board.player2  #No deja jugar un player que no pertenece al gamerai

        @board.result=params[:result]
        @board.turn=@board.turn+1 #Incremento el turno en 1, porque marcar una celda representa un turno

        @board.winner_game #Llamo al método de instancia para ver si uno de los dos jugadores gana la partida

        game_save
    end
        
    
    def check_token
        token = request.headers["Authorization"].split(" ") #Tengo que usar split porque el front envía "Bearer token" y solo necesito el token.
        @player=Player.find_by(token: token[1])#En token[0] queda "Bearer"

        return if @player.present?
        #dejar espacio despues de return para buena costumbre. Si la condicion de if se cumple, la 
        #funcion retorna. Sino sigue con render status
        render status: 401, json:{message: "Debe iniciar sesión con un usuario válido"}#Si llega a esta línea de código, significa que se ha introducido manualmente un token incorrecto en el front en lugar de seguir el procedimiento normal de inicio de sesión
        false #false necesario para que no se ejecute el action que ha llamado check_token como callback
    end
    
    private

    def update_board
        board = Board.find_by(id: params[:id])
        if board.present?
            if board.update(board_params)
                render status:200 ,json: {board: board}
            else 
                render status:400, json: {message: board.errors.details}
            end
        else
            render status:404 , json: {message: "No se encuentra el tablero #{params[:id]}"}
        end
    end
    
    def board_params
        params.permit(:winner,:player_1,:player_2, :board_name)
    end

end
