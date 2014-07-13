module ApplicationHelper
  def full_title(title, base = 'Kodets')
    (title.empty? ? base : "#{title} | #{base}").html_safe
  end

  def authenticate_user_with_org!
    org = Organisation.find_by(ref: params[:ref])
    unless current_teacher && current_teacher.organisation == org
      flash[:warning] = "You do not have permission to access this page"
      redirect_to root_path
    end
  end

  # Similar implementation to ActionView::Helpers::TextHelper#pluralize
    # but returns Array of two values instead of one String
  def pluralise(count, singular)
    [
      (count || 0),
      (count == 1 || count =~ /^1(\.0+)?$/) ? singular : singular.pluralize
    ]
  end
end
