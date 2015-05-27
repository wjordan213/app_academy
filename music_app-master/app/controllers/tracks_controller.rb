class TracksController < ApplicationController
  before_action :is_logged_in?


  def new
    @track = Track.new(album_id: params[:album_id])
    @albums = Album.all
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to new_album_track_url(@track.album_id)
    end
  end

  def show
    @track = Track.find(params[:id])
  end

  def edit
    @albums = Album.all
    @track = Track.find(params[:id])
  end

  def update
    track = Track.find(params[:id])
    if track.update(track_params)
      redirect_to track_url(track)
    else
      flash[:errors] = track.errors.full_messages
      redirect_to edit_track_url(params[:id])
    end
  end

  def destroy
    track = Track.find(params[:id])
    album = track.album
    track.destroy
    redirect_to album_url(album)
  end

  private

  def track_params
    params[:track].permit(:album_id, :bonus_or_regular, :lyrics, :name)
  end
end
