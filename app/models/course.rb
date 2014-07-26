class Course < ActiveRecord::Base
  belongs_to :organisation

  VALID_COLOUR_FORMAT = /#{1}[0-9]{6}/i

  validates :name,            presence: true, lenght: { maximum: 140 }
  validates :description,     presence: true, lenght: { maximum: 250 }
  validates :organisation_id, presence: true
  validates :colour,          presence: true, format: { with: VALID_COLOUR_FORMAT }

  def to_param
    [id, name.parameterize].join('-')
  end
end
