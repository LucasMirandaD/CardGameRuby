class Board < ApplicationRecord
  ##############################################################################
  # ASSOCIATIONS
  ##############################################################################
  belongs_to :player1, class_name: 'Player', foreign_key: 'player1_id'
  belongs_to :player2, class_name: 'Player', foreign_key: 'player2_id', optional: true
  has_one :deck, dependent: :restrict_with_error # permite el borrado en cascada, destroy no funciono

  ##############################################################################
  # VALIDATIONS
  ##############################################################################
  validates :player1, :deck, presence: true
end
