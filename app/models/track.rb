class Track < ActiveRecord::Base
  belongs_to :course
  has_many :code_lessons, dependent: :destroy

  validates :name,        presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 250 }

  def to_param
    [id, name.parameterize].join('-')
  end
end
