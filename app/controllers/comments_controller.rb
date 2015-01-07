class CommentsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id

    redirect_url = ''
    if comment_params[:commentable_type] == 'Event'
      redirect_url = event_path(@commentable)
    end
    if comment_params[:commentable_type] == 'WikiPage'
      redirect_url = "#{request.protocol}#{request.host_with_port}/wiki/#{@commentable.url}"
    end

    if @comment.save
      redirect_to redirect_url, flash: {notice: 'Commentaire ajouté'}
    else
      redirect_to redirect_url, flash:
          {error: "Impossible d'ajouter le commentaire: #{@comment.errors.join(',')}"}
    end
    # respond_to do |format|
    #   format.html { render layout: false }
    # end
  end

  def destroy
    raise 'not implemented'
    # @event = Event.find(attendance_params[:event_id])
    # Attendance.where(user_id: current_user.id, event_id: @event.id).destroy_all
    # respond_to do |format|
    #   format.html { render layout: false }
    # end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :commentable_id, :commentable_type)
  end

  def find_commentable
    if comment_params[:commentable_type] == 'Event'
      Event.find(comment_params[:commentable_id].to_i)
    elsif comment_params[:commentable_type] == 'WikiPage'
      WikiPage.find(comment_params[:commentable_id].to_i)
    elsif params[:post_id]
      # whatever
    end
  end

end
