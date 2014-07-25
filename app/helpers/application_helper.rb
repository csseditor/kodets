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

  def authenticate_user!
    unless teacher_signed_in? || student_signed_in?
      flash[:info] = 'You need to be signed in to do that.'
      redirect_to root_url
    end
  end
end
