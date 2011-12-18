class EventsController < ApplicationController
  include PreLoginParams

  keep_params :event, :only => [:create]
  load_params :event, :only => [:new]

  load_and_authorize_resource :event, :only => [:show, :edit]
  load_and_authorize_resource :through => :current_user, :only => [:create, :update]

  respond_to :html, :atom

  def index
    @presenter = Events::IndexPresenter.new
    @events = Event.page params[:page]
    respond_with @events
  end

  def create
    if @event.save
      redirect_to @event, :notice => t('event.flash.created')
    else
      render :new
    end
  end

  def update
    if @event.update_attributes params[:event]
      redirect_to @event, :notice => t('event.flash.updated')
    else
      render :edit
    end
  end
end
