class PlayersController < ApplicationController
    
    before_action :check_token ,except: [:login, :create]#, only: [ :show,]

    def index
        @players = Player.all
        render status:200 ,json: {players: @players}
    end
    
    def show
        @player = Player.find_by(nickname: params[:nickname])
        
        if @player.present?
            render status:200 ,json: {players: @player}
        else
            render status:404 , json: {message: "no se encuentra el jugador #{params[:nickname]}"}
        end
    end

    def login
        @player = Player.find_by(nickname: params[:nickname], password: params[:password])
        
        if @player.present?
            render status:200 ,json: {player: @player}
        else
            render status:404 , json: {message: "no se encuentra el jugador #{params[:nickname]}"}
        end
    end


    def create #poner privadas las funciones
        @player = Player.create(player_params)

        if @player.persisted?
            render status:200 ,json: {player: @player}
        else 
            render status:400, json: {message: @player.errors.details}
        end
    end

    def update   
        player = Player.find_by(nickname: params[:nickname])

        if player.present?
            if player.update(player_params)
                render status:200 ,json: {player: player}
            else 
                render status:400, json: {message: player.errors.details}
            end
        else
            render status:404 , json: {message: "No se encuentra el jugador #{params[:id]}"}
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
    
    def login
        @player=Player.where(nickname: params[:nickname], password: params[:password])
        if @player.present?
           render status: 200, json: {player: @player}
        else
           render status: 404, json: {message: "No existe el jugador o la contraseña es incorrecta."}
        end
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
    
    def player_params
        params.permit(:name,:lastname,:password,:nickname)
    end
    

end
