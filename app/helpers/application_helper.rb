module ApplicationHelper
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

  def title_options
    # The options for different titles users can have.
    %w(Mr. Mrs. Miss Ms Dr. Prof.)
  end

  def default_selected_title
    # The option that is selected by default in the user update form.
    resource.title || 'Please select a title...'
  end

  def current_org
    current_user ? Organisation.find(current_user.organisation_id) : nil
  end

  def teacher_user
    unless current_user.teacher?
      flash[:warning] = 'You do not have the correct permissions to access this page.'
      redirect_to root_path
    end
  end
end
