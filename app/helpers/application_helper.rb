module ApplicationHelper
  def full_title(page_title)
    base_title = 'Kodets'
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def authenticate_organisation
    unless organisation_signed_in?
      flash[:warning] = "You need to be signed into an Organisation to do that."
      redirect_to new_organisation_session_path
    end
  end
end
