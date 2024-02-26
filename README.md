# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version -> 3.2.0
* Rails version -> 7.0.8
* Este proyecto usa postgre
* Lo primero que debes hacer:
 ### bundle install && rails db:drop && rails db:create && rails db:migrate && rails s

# API Documentation

## Base URL
`http://127.0.0.1:3000/`

## Authentication
La mayoría de los endpoints requieren un token de autenticación, enviado como encabezado de Autorización en el formato `Authorization: Bearer {token}`. 

## Endpoints Overview

| Endpoint                                          | Método | Requiere Autenticación | JSON de Envío                            | JSON de Respuesta                                | Descripción                                  |
|---------------------------------------------------|--------|------------------------|------------------------------------------|--------------------------------------------------|----------------------------------------------|
| **Players**                                       |        |                        |                                          |                                                  |                                              |
| `/api/players`                                    | GET    | Sí                     | N/A                                      | `{ players: [ {id, token}, {...} ] }`           | Devuelve una lista de todos los jugadores.    |
| `/api/players/:id`                                | GET    | Sí                     | N/A                                      | `{ player: {...}, image_url: 'URL', deck: [...] }` | Devuelve información detallada sobre un jugador. |
| `/api/players/login`                              | POST   | No                     | `{ player: {email, password} }`         | `{ id, token }`                                  | Inicia sesión de un jugador.                 |
| `/api/players`                                    | POST   | No                     | `{ player: {name, password, email, nickname} }` | `{ player: {...}, image_url: 'URL' }`       | Crea un nuevo jugador.                       |
| `/api/players/:id`                                | PATCH  | Sí                     | `{ player: {current_password, new_password} }` | `{ player: {...} }`                          | Actualiza la información de un jugador.      |
| `/api/players/:id`                                | DELETE | Sí                     | N/A                                      | `{ message: "Se eliminó el jugador correctamente" }` | Elimina un jugador.                          |
| `/api/players/:player_id/update_image`            | PUT    | Sí                     | `{ image: {file} }`                      | `{ data: {id, token}, image_url: 'URL' }`        | Actualiza la imagen de perfil de un jugador. |
| `/api/players/:player_id/cards_count`             | GET    | Sí                     | N/A                                      | `{ count: 5 }`                                  | Devuelve la cantidad de cartas de un jugador.|
| **Boards**                                        |        |                        |                                          |                                                  |                                              |
| `/api/boards`                                     | GET    | Sí                     | N/A                                      | `{ boards: [ {...}, {...} ] }`                   | Devuelve una lista de todos los tableros.    |
| `/api/boards/my_games`                            | GET    | Sí                     | N/A                                      | `{ boards: [ {...}, {...} ] }`                   | Devuelve los tableros en los que el jugador está participando. |
| `/api/boards/wins`                                | GET    | Sí                     | N/A                                      | `{ boards: [ {...}, {...} ] }`                   | Devuelve los tableros ganados por el jugador. |
| `/api/boards/:id`                                 | GET    | Sí                     | N/A                                      | `{ board: {...}, deck: [...] }`                   | Devuelve información detallada sobre un tablero. |
| `/api/boards`                                     | POST   | Sí                     | `{ board: {player1_id, board_name} }`   | `{ board: {...} }`                               | Crea un nuevo tablero.                       |
| `/api/boards/:id`                                 | PATCH  | Sí                     | `{ board: {winner, player1, player2} }` | `{ board: {...} }`                               | Actualiza la información de un tablero.      |
| `/api/boards/:id`                                 | DELETE | Sí                     | N/A                                      | `{ message: "Se destruyó el tablero correctamente" }` | Elimina un tablero.                          |
| `/api/boards/:board_id/join_board`                | PATCH  | Sí                     | `{ board: {player2_id} }`               | `{ messages: 'Te has unido a la partida exitosamente' }` | Unirse a un tablero.                        |
| `/api/boards/:board_id/take_card`                | PATCH  | Sí                     | `{ board: {player_id} }`                 | `{ card: {...} }`                                | Tomar una carta del tablero.                 |
| `/api/boards/:board_id/throw_card`               | PATCH  | Sí                     | `{ board: {player_id, card_url} }`      | `{ message: 'URL de la carta' }`                | Tirar una carta al tablero.                  |
| `/api/boards/:board_id/deal_cards`               | PATCH  | Sí                     | N/A                                      | `{}`                                             | Repartir cartas a los jugadores.             |
| `/api/boards/:board_id/game_over`                | PATCH  | Sí                     | `{ board: {winner_id} }`                | `{ message: 'Ganador' }`                        | Finalizar el juego y declarar un ganador.    |
| `/api/boards/:board_id/last_card`                | GET    | Sí                     | N/A                                      | `{ url: 'URL de la última carta' }`             | Obtener la última carta tirada en el tablero. |
| `/api/boards/:board_id/score`                    | GET    | Sí                     | N/A                                      | `{ scores: [ {id, nickname, score}, {...} ] }`  | Obtener la puntuación de los jugadores.      |
| `/api/boards/:board_id/increase_score`           | PATCH  | Sí                     | `{ board: {player_id} }`                | `{ message: 'Puntuación incrementada correctamente' }` | Incrementar la puntuación de un jugador.    |
| `/api/boards/:board_id/shuffle_cards`            | PATCH  | Sí                     | N/A                                      | `{ deck: [...cartas barajadas...] }`            | Barajar las cartas del tablero.              |
| `/api/boards/:board_id/reset_game`               | PATCH  | Sí                     | N/A                                      | `{}`                                             | Reiniciar el juego y los tableros.          |


