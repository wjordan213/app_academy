class NotesController < ApplicationController
  before_action :is_logged_in?
  def create
    note = Note.new(note_params)
    note.user_id = current_user.id
    note.save
    redirect_to track_url(note.track.id)
  end

  def destroy
    note = Note.find(params[:id])
    if current_user == note.user
      track = note.track
      note.destroy
      redirect_to track_url(track)
    else
      render status: 403, text: 'ah, ah, ah'
    end
  end

  private

  def note_params
    params.require(:note).permit(:content, :track_id)
  end
end
