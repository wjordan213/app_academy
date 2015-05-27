class AlbumsController < ApplicationController
  before_action :is_logged_in?
  # views: :new, :show, :edit
  def new
    @bands = Band.all
    @album = Album.new(band_id: params[:band_id])
  end

  def create
    album = Album.new(album_params)
    album.band_id = params[:band_id]
    if album.save
      redirect_to album_url(album)
    else
      flash[:errors] = album.errors.full_error_messages
      redirect_to new_band_album_url(params[:band_id])
    end
  end

  def show
    @album = Album.find(params[:id])
    @band = Band.find(@album.band_id)
  end

  def edit
    @bands = Band.all
    @album = Album.find(params[:id])
  end

  def update
    album = Album.find(params[:id])
    if album.update(album_params)
      redirect_to album_url(album)
    else
      flash[:errors] = album.errors.full_error_messages

      redirect_to edit_album_url(album)
    end
  end

  def destroy
    album = Album.find(params[:id])
    band = album.band
    album.destroy
    redirect_to band_url(band)
  end

  private

  def album_params
    params[:album].permit(:name, :studio_or_live)
  end
end
