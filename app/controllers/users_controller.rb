class UsersController < ApplicationController
  load_and_authorize_resource :only => [:index, :show]

  def show
    @presenter = Users::ShowPresenter.new(@user)
  end
end
