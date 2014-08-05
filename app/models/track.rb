class Track < ActiveRecord::Base
  belongs_to :course

  validates :name,        presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 250 }

  def to_param
    [id, name.parameterize].join('-')
  end
end
