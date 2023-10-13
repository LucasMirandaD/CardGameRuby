class Image < ApplicationRecord
  ##############################################################################
  # ASSOCIATIONS
  ##############################################################################
  belongs_to :player
  has_one_attached :file

  ##############################################################################
  # VALIDATIONS
  ##############################################################################
  validates :file, presence: true
  validates :file, content_type: ['image/png', 'image/jpeg', 'image/jpg']

  ##############################################################################
  # INSTANCE METHODS
  ##############################################################################
  def url
    Rails.application.routes.url_helpers.rails_blob_path(file, only_path: true)
  end

  def full_url
    Rails.application.routes.url_helpers.url_for(file)
  end
end
