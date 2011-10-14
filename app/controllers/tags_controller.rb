class TagsController < ApplicationController
  layout "questions"

  def index
    @tags = Question.tag_counts
  end
end
