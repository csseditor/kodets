class CodeLesson < ActiveRecord::Base
  belongs_to :track

  after_validation :make_visible

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
