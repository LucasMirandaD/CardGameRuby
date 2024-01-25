class Player < ApplicationRecord
  before_create :set_token
  ##############################################################################
  # ASSOCIATIONS
  ##############################################################################
  has_many :boards
  has_one :image
  accepts_nested_attributes_for :image
  has_one :deck, dependent: :restrict_with_error

  ##############################################################################
  # VALIDATIONS
  ##############################################################################
  validates :nickname, :email, uniqueness: true, presence: true

  ##############################################################################
  # INSTANCE METHODS
  ##############################################################################
  def set_token
    self.token = SecureRandom.uuid
  end
end
