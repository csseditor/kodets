module TracksHelper

  # Find other lessons in the current track
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
end
