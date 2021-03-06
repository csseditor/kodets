module ApplicationHelper
  # Produces title for pages
  def full_title(title, base = 'Kodets')
    (title.empty? ? base : "#{title} | #{base}").html_safe
  end

  # Similar implementation to ActionView::Helpers::TextHelper#pluralize
  # but returns Array of two values instead of one String
  def pluralise(count, singular)
    [
      (count || 0),
      (count == 1 || count =~ /^1(\.0+)?$/) ? singular : singular.pluralize
    ]
  end

  # Assign current_org to the organisation that current_user belongs to
  def current_org
    user_signed_in? ? Organisation.find(current_user.organisation_id) : nil
  end

  # Renders long or short footer
  def render_footer
    if large_footer?
      render 'layouts/large_footer'
    else
      render 'layouts/small_footer'
    end
  end

  # Only show large footer when user not signed in
  def large_footer?
    !user_signed_in?
  end

  # Short method for checking if on certain page
  def on_page(given_controller_name, given_action_name)
    controller.controller_name == given_controller_name &&
    controller.action_name == given_action_name
  end

  # Renders a link in the footer and highlights if it is on that page
  def footer_link(link_text, link, given_controller_name, given_action_name)
    if on_page(given_controller_name, given_action_name)
      "<li class='active'><a href='#{link}'>#{link_text}</a></li>".html_safe
    else
      "<li><a href='#{link}'>#{link_text}</a></li>".html_safe
    end
  end

  # Returns path for different lesson types
  def path_for_lesson(item)
    case item.class.name
    when 'CodeLesson'
      code_lesson_path(item)
    when 'VideoLesson'
      video_lesson_path(item)
    when 'Quiz'
      first_question_quiz_path(item)
    when 'TextLesson'
        text_lesson_path(item)
    when 'Competition'
      competition_path(item)
    else
      '#'
    end
  end

  # Links to next lesson in path, or back to track
  def link_to_next_lesson(item, options = { link_text: 'Next Lesson' })
    track = item.track
    track_items = track.items.sort_by! { |i| i.order }
    next_item = track_items.find { |i| i.order > item.order && i.visible? } if track_items

    if next_item
      link_to options[:link_text],
              path_for_lesson(next_item),
              class: "btn btn-success next-lesson-button #{options[:class]}",
              id: options[:id]
    else
      link_to 'Back to Track',
              track_path(track),
              class: "btn btn-primary next-lesson-button #{options[:class]}",
              id: options[:id]
    end
  end

  # Used to update the order of lessons in a track, finds item based on id and
  # class name.
  def find_lesson_from_class_id(id, item_type)
    case item_type
    when 'CodeLesson'
      CodeLesson.find(id) || nil
    when 'VideoLesson'
      VideoLesson.find(id) || nil
    when 'Quiz'
      Quiz.find(id) || nil
    when 'TextLesson'
      TextLesson.find(id) || nil
    else
      nil
    end
  end

  def find_progress_from_item_user(item, user)
    @progress = Progress.where('user_id = ? AND lesson_type = ? AND lesson_id = ?',
                               user.id, item.class.name, item.id).first
  end
end
