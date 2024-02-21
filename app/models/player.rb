class Player < ApplicationRecord
  before_create :set_token
  ##############################################################################
  # ASSOCIATIONS
  ##############################################################################
  has_many :boards
  has_one :deck, dependent: :restrict_with_error
  has_one_attached :image, dependent: :destroy
  # , dependent: :destroy

  ##############################################################################
  # VALIDATIONS
  ##############################################################################
  validates :nickname, :email, uniqueness: true, presence: true
  validates :image, presence: true

  ##############################################################################
  # INSTANCE METHODS
  ##############################################################################
  def set_token
    self.token = SecureRandom.uuid
  end
end
