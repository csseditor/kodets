module CodeLessonsHelper

  # Returns a human-readable sentence of missing fields needed for the lesson
  # to be public
  def required_empty_fields(code_lesson)
    fields = %w[name language_id lesson_content instructions order]
    missing = []
    fields.each do |field|
      missing.push(field.humanize) if code_lesson.read_attribute(field).blank?
    end

    missing.any? ? missing.to_sentence : 'nothing'
  end
end
