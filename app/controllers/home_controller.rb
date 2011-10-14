class HomeController < ApplicationController
  def index
    @presenter = Home::IndexPresenter.new
  end
end
