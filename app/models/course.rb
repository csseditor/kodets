class Course < ActiveRecord::Base
  belongs_to :organisation

  VALID_COLOUR_FORMAT = /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/

  validates :name,            presence: true, length: { maximum: 140 }
  validates :description,     presence: true, length: { maximum: 250 }
  validates :organisation_id, presence: true
  validates :colour,          presence: true, format: { with: VALID_COLOUR_FORMAT }

  def to_param
    [id, name.parameterize].join('-')
  end
end
