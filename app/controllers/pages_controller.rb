class PagesController < ApplicationController
  before_action :authenticate_teacher!, only: :teacher_dashboard
  before_action :dashboard_redirect, only: :home

  def home
  end

  def pricing
  end

  def about
  end

  def contact
  end

  def teacher_dashboard
  end

  private

  def dashboard_redirect
    redirect_to teacher_dashboard_path if teacher_signed_in?
  end
end
