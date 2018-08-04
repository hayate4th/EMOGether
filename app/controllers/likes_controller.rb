class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @emomusic = Emomusic.find(params[:emomusic_id])
    unless @emomusic.like?(current_user)
      @emomusic.like(current_user)
      @emomusic.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @emomusic = Like.find(params[:id]).emomusic
    if @emomusic.like?(current_user)
      @emomusic.unlike(current_user)
      @emomusic.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end