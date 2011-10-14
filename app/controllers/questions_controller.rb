class QuestionsController < ApplicationController
  include HitView
  include PreLoginParams

  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'

  keep_params :question, :only => [:create]

  load_params :question, :only => [:new]
  load_params :answer, :only => [:show]

  load_and_authorize_resource :question, :only => [:show, :vote, :edit]
  load_and_authorize_resource :through => :current_user, :only => [:create, :update]

  hit_view
  respond_to :html, :atom

  helper_method :sort_column, :sort_direction

  def index
    @questions = Question.with_tag(params[:tag]).includes(:user, :tags).order("#{sort_column} #{sort_direction}").page params[:page]
    respond_with @questions
  end

  def show
    @answers = @question.answers_page params[:page]
    respond_with @answers
  end

  def create
    if @question.save
      redirect_to @question, :notice => t('question.flash.created')
    else
      render :new
    end
  end

  def update
    if @question.update_attributes params[:question]
      redirect_to @question, :notice => t('question.flash.updated')
    else
      render :edit
    end
  end

  def vote
    flash[:notice] = @question.vote current_user, params[:vote]
    redirect_to @question
  end

  private

  def sort_column
    Question.sortable?(params[:sort]) ? params[:sort] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end
end
