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
end
