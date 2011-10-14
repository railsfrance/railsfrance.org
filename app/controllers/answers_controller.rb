class AnswersController < ApplicationController
  include PreLoginParams

  keep_params :answer, :only => [:create]

  load_and_authorize_resource :only => [:vote, :accept]
  load_and_authorize_resource :question

  def create
    if current_user.answers.create(params[:answer].merge(:question => @question))
      redirect_to @question, :notice => t('answer.flash.created')
    else
      @answers = @question.answers_page(params[:page])
      render 'questions/show'
    end
  end

  def vote
    flash[:notice] = @answer.vote(current_user, params[:vote])
    redirect_to @question
  end

  def accept
    if @question == @answer.question
      @question.accepted_answer = @answer
      flash[:notice] = t('answer.flash.answered') if @question.save
    end
    redirect_to @question
  end
end
