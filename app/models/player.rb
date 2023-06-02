class Player < ApplicationRecord
    validates :nickname, uniqueness: true, presence: true
    has_many :boards
    before_create :set_token


    def set_token
        self.token=SecureRandom.uuid
    end
end
