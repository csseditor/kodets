class Track < ActiveRecord::Base
  belongs_to :course

  def to_param
    [id, name.parameterize].join('-')
  end
end
