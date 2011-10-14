class EventsController < ApplicationController
  include PreLoginParams

  keep_params :event, :only => [:create]
  load_params :event, :only => [:new]
  load_params :comment, :only => [:show]

  load_and_authorize_resource :event, :only => [:show, :edit, :attend, :unattend]
  load_and_authorize_resource :through => :current_user, :only => [:create, :update]

  respond_to :html, :atom

  def index
    @presenter = Events::IndexPresenter.new
    @events = Event.includes(:user).page params[:page]
    respond_with @events
  end

  def show
    @comments = @event.comments_page params[:page]
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

  def attend
    @event.attendees << current_user
    flash[:notice] = t('event.flash.attended') if @event.save
    redirect_to @event
  end

  def unattend
    @event.attendees.destroy current_user
    flash[:notice] = t('event.flash.unattended') if @event.save
    redirect_to @event
  end
end
