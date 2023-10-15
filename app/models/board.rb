class Board < ApplicationRecord
  ##############################################################################
  # ASSOCIATIONS
  ##############################################################################
  belongs_to :player1, class_name: 'Player', foreign_key: 'player1_id'
  belongs_to :player2, class_name: 'Player', foreign_key: 'player2_id', optional: true

  ##############################################################################
  # VALIDATIONS
  ##############################################################################
  validates :player1, presence: true
end
