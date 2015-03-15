class FollowsController < ApplicationController

  def index
    @playlist = Playlist.find(params[:playlist_id])
    @follow = @playlist.follows.new
    @follow.followerId = current_user.id
    @follow.save
    flash[:notice] = "You are now following #{@playlist.name}"
    redirect_to user_playlists_path(@playlist.user)
  end

end
