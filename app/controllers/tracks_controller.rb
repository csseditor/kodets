class TracksController < ApplicationController
  before_action :teacher_user, only: [:new, :create, :edit, :update, :destroy]

  def new
    @track = Track.new
  end

  def create
    @course = Course.find params[:id]
    @track = @course.tracks.build track_params
    if @track.save
      flash[:success] = 'Track saved'
      redirect_to track_path @track
    else
      render :new
    end
  end

  def edit
    @track = Track.find params[:id]
  end

  def update
  end

  def show
    @track = Track.find params[:id]
  end

  def index
    @tracks = Track.all.where organisation_id: current_org.id
  end

  def destroy
    @track = Track.find params[:id]
  end

  private

  def track_params
    params.require(:track).permit(:name, :description, :order)
  end
end
