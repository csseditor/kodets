class TracksController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end

  def index
  end

  def destroy
  end

  private

  def track_params
    params.require(:course).permit(:name, :description)
  end
end
