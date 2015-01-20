class CodeLesson < ActiveRecord::Base
  belongs_to :track
  belongs_to :language

  after_validation :make_visible

  validates :name,            presence: true, length: { maximum: 50 }
  validates :lesson_content,  presence: true, on: :update
  validates :instructions,    presence: true, on: :update
  validates :organisation_id, presence: true
  validates :language_id,     presence: true
  validates :user_id,         presence: true
  validates :track_id,        presence: true


  def to_param
    [id, name.parameterize].join('-')
  end

  def visible?
    visible
  end

  def shareable?
    shareable
  end

  private

    def make_visible
      if name.present? && language_id.present? && lesson_content.present? &&
        instructions.present? && order.present?
        self.visible = true
      end
    end
end
