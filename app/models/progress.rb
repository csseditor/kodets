class Progress < ActiveRecord::Base
  belongs_to :user

  def lesson
    case self.lesson_type
    when 'CodeLesson'
      CodeLesson.find self.lesson_id
    else
      nil
    end
  end
end
