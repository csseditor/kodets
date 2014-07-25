class PagesController < ApplicationController
  before_action :dashboard_redirect, only: :home

  def home; end
  def pricing; end
  def about; end
  def contact; end

  private

  def dashboard_redirect
    redirect_to dashboard_path if teacher_signed_in?
  end
end
