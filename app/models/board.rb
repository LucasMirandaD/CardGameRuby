class Board < ApplicationRecord
    belongs_to :player_1 , class_name: "Player"
    belongs_to :player_2 , class_name: "Player", optional: true

 OPTIONS= [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
 ]; 
#  Esta constante dice la posiciones ganadoras

# Metodo para veruficar el ganador

    def winner_game
        winner_result = self.result.split(",") #de string del front --> array


        Board::OPTIONS.each do |combination|

            a= combination[0]
            b= combination[1]
            c= combination[2]

            if(winner_result[a]=="O" 
                && winner_result[a] == winner_result[b]  
                && winner_result[a] == winner_result[c] )
                self.winner=self.player_1
            end
            if(winner_result[a]=="X" 
                && winner_result[a] == winner_result[b]  
                && winner_result[a] == winner_result[c] )
                self.winner=self.player_2
            end
        end
    end




end
