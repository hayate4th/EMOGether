class EmomusicsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
      @emomusic = current_user.emomusics.build(emomusic_params)
      if @emomusic.save
          flash[:success] = "Emomusic added!"
          redirect_to root_url
      else
          @feed_items = []
          render 'static_pages/home'
      end
  end

  def destroy
    @emomusic.destroy
    flash[:success] = "Emomusic deleted"
    redirect_to request.referrer || root_url
  end

  private

      def emomusic_params
          params.require(:emomusic).permit(:title, :composer)
      end

      def correct_user
        @emomusic = current_user.emomusics.find_by(id: params[:id])
        redirect_to root_url if @emomusic.nil?
      end
end
