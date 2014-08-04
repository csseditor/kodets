class UsersController < ApplicationController
  before_action :teacher_user, only: :index

  def index
    @users = User.all.where(organisation_id: current_org.id)
  end
end
