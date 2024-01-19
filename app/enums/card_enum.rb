module CardEnum
  extend ActiveSupport::Concern

  CARD_ENUM_VALUES = [
    '/images/cards/blue/0.png',
    '/images/cards/blue/1.png',
    '/images/cards/blue/2.png',
    '/images/cards/blue/3.png',
    '/images/cards/blue/4.png',
    '/images/cards/blue/5.png',
    '/images/cards/blue/6.png',
    '/images/cards/blue/7.png',
    '/images/cards/blue/8.png',
    '/images/cards/blue/9.png',
    '/images/cards/blue/chupate2.png',
    '/images/cards/blue/darVuelta.png',
    '/images/cards/blue/prohibido.png',
    '/images/cards/green/0.png',
    '/images/cards/green/1.png',
    '/images/cards/green/2.png',
    '/images/cards/green/3.png',
    '/images/cards/green/4.png',
    '/images/cards/green/5.png',
    '/images/cards/green/6.png',
    '/images/cards/green/7.png',
    '/images/cards/green/8.png',
    '/images/cards/green/9.png',
    '/images/cards/green/chupate2.png',
    '/images/cards/green/darVuelta.png',
    '/images/cards/green/prohibido.png',
    '/images/cards/red/0.png',
    '/images/cards/red/1.png',
    '/images/cards/red/2.png',
    '/images/cards/red/3.png',
    '/images/cards/red/4.png',
    '/images/cards/red/5.png',
    '/images/cards/red/6.png',
    '/images/cards/red/7.png',
    '/images/cards/red/8.png',
    '/images/cards/red/9.png',
    '/images/cards/red/chupate2.png',
    '/images/cards/red/darVuelta.png',
    '/images/cards/red/prohibido.png',
    '/images/cards/yellow/0.png',
    '/images/cards/yellow/1.png',
    '/images/cards/yellow/2.png',
    '/images/cards/yellow/3.png',
    '/images/cards/yellow/4.png',
    '/images/cards/yellow/5.png',
    '/images/cards/yellow/6.png',
    '/images/cards/yellow/7.png',
    '/images/cards/yellow/8.png',
    '/images/cards/yellow/9.png',
    '/images/cards/yellow/chupate2.png',
    '/images/cards/yellow/darVuelta.png',
    '/images/cards/yellow/prohibido.png',
    '/images/cards/special/cambioColor.png',
    '/images/cards/special/chupate4.png'
  ].freeze

  included do
    def self.cards
      CARD_ENUM_VALUES
    end
  end
end
