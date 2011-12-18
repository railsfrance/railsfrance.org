class UsersController < ApplicationController
  load_and_authorize_resource :only => [:show]

  def index
    @presenter = Users::IndexPresenter.new
    @users = User.page params[:page]
  end

  def show
    @presenter = Users::ShowPresenter.new(@user)
  end
end
