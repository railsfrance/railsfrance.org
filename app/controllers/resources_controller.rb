class ResourcesController < ApplicationController
  def index
    @presenter = Resources::IndexPresenter.new
  end
end
