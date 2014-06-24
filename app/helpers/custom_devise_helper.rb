module CustomDeviseHelper
  def authenticate_organisation
    unless organisation_signed_in?
      flash[:warning] = "You need to be signed into an Organisation to do that."
      redirect_to new_organisation_session_path
    end
  end

  def user_controller?
    controller_name == 'user_sessions' || controller_name == 'user_registrations'
  end

  def organisation_controller?
    controller_name == 'sessions' || controller_name == 'registrations'
  end
end
