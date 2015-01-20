module TracksHelper

  # Find other lessons in the current track
  # Returns @other_lessons object
  def find_lessons_in_same_track(track)
    @other_lessons = CodeLesson.where('track_id = ?', track.id)
                     # VideoLesson.where('track_id = ?', track.id) +
                     # Quiz.where('track_id = ?', track.id)
  end

  # Generates order for new lesson in track
  def find_order
    find_lessons_in_same_track Track.find(params[:id])
    @other_lessons.present? ? @other_lessons.map(&:order).max + 1 : 1
  end

  def link_to_next_lesson(item, options = {})
    track = item.track
    track_items = track.items.sort_by! { |i| i.order }
    next_item = track_items.find { |i| i.order > item.order && i.visible? } if track_items

    if next_item
      case next_item.class.name
      when 'CodeLesson'
        path = code_lesson_path(next_item)
      when 'VideoLesson'
        path = video_lesson_path(next_item)
      when 'DebugLesson'
        path = debug_lesson_path(next_item)
      when 'Quiz'
        path = quiz_path(next_item)
      when 'Competition'
        path = competition_path(next_item)
      end

      link_text = options[:link_text] || 'Next Lesson'

      link_to link_text, path,
                         class: "btn btn-success next-lesson-button #{options[:class]}",
                         id: options[:id]
    else
      link_to 'Back to Track', track_path(track),
                               class: "btn btn-primary next-lesson-button #{options[:class]}",
                               id: options[:id]
    end
  end
end
