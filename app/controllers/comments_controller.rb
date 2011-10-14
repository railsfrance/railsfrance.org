class CommentsController < ApplicationController
  include PreLoginParams

  keep_params :comment, :only => [:create]

  def create
    @comment = current_user.comments.build(params[:comment])
    @parent = parent_object
    @comment.commentable = @parent
    if @comment.save
      redirect_to @parent, :notice => t('comment.flash.created')
    else
      @comments = @parent.comments_page(params[:page])
      render 'events/show'
    end
  end

  private

  def parent_object
    case
      when params[:event_id] then Event.find(params[:event_id])
      when params[:news_id] then News.find(params[:news_id])
    end
  end
end
