class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @emomusic  = current_user.emomusics.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @likes = Like.where(emomusic_id: params[:emomusic_id])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
