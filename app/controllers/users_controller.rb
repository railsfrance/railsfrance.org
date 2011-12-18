class UsersController < ApplicationController
  load_and_authorize_resource :only => [:show]

  def index
    @users = User.page params[:page]
  end

  def show
    @presenter = Users::ShowPresenter.new(@user)
  end
end
