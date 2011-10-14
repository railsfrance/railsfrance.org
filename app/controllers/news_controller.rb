class NewsController < ApplicationController
  include PreLoginParams

  respond_to :html, :atom

  load_params :comment, :only => [:show]
  load_and_authorize_resource :only => [:show]

  def index
    @news = News.includes(:user).page params[:page]
    respond_with @news
  end

  def show
    @comments = @news.comments_page params[:page]
  end
end
