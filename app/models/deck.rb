class Deck < ApplicationRecord
  ##############################################################################
  # ASSOCIATIONS
  ##############################################################################
  belongs_to :board, optional: true
  belongs_to :player, optional: true

  ##############################################################################
  # VALIDATIONS
  ##############################################################################
end