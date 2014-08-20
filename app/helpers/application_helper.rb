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
    current_user ? Organisation.find(current_user.organisation_id) : nil
  end

  # Redirect home unless current_user is a teacher
  def teacher_user
    unless current_user.teacher?
      flash[:warning] = 'You do not have the correct permissions to access this page.'
      redirect_to root_path
    end
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
end
