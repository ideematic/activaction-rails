class LikesController < ApplicationController
  protect_from_forgery except: [:create, :destroy]

  def create
    @like = Like.create like_params
  end

  def destroy
    @like = Like.where(user_id: like_params[:user_id]).where(event_id: like_params[:event_id]).first
    @likable = @like.event # save the event for rendering
    @like.delete
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :event_id)
  end
end