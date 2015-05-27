class BandsController < ApplicationController
  # views: :index, :new, :show
  before_action :is_logged_in?
  def index
    @bands = Band.all
  end

  def new
    @band = Band.new
  end

  def create
    band = Band.new(band_params)
    if band.save
      redirect_to band_url(band)
    else
      redirect_to new_band_url
    end
  end

  def show
    @band = Band.find(params[:id])
    # renders :show
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    band = Band.find(params[:id]).update(band_params)
    if band
      redirect_to band_url(params[:id])
    else
      redirect_to edit_band_url(params[:id])
    end
  end

  def destroy
    Band.find(params[:id]).destroy
    redirect_to bands_url
  end

  private

  def band_params
    params[:band].permit(:name)
  end
end
