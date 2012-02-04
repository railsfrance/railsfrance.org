class JobsController < ApplicationController
  include Messages

  before_filter :load_from_session, :only => [:preview, :confirm]
  before_filter :load_from_params, :only => [:show, :update]

  respond_to :html, :atom

  def index
    params[:search_job] ||= {}
    @search = Search::Job.new params[:search_job]
    @jobs = @search.execute.page params[:page]
    respond_with @jobs
  end

  def new
    @job = Job.new
  end

  def show
    unless @job.activated?
      error(:job_not_activated)
      redirect_to :root
    end
  end

  def create
    @job = Job.new params[:job]

    if verify_recaptcha(model: @job, message: I18n.t('recaptcha.errors.verification_failed')) && @job.save
      session[:job_id] = @job.id
      redirect_to preview_jobs_path
    else
      error(:form_not_valid, {now: true})
      render(:new) and return
    end
  end

  def edit
    redirect_to :root and return unless
      @job = Job.with_state(:activated).where(:token => params[:token]).first
    render :new
  end

  def update
    if @job.update_attributes(params[:job])
      notice(:job_updated)
      redirect_to(@job) and return
    else
      error(:job_not_updated, {now: true})
      render :new and return
    end
  end

  def preview
    render :show
  end

  def confirm
    @job.confirm!
    ContactMailer.confirm_job(@job).deliver
    session[:job_id] = nil
    notice(:job_confirmation) and redirect_to :root
  end

  def validate
    redirect_to :root and return unless @job = Job.with_state(:confirmed).where(:token => params[:token]).first
    @job.activate!
    ContactMailer.valid_job(@job).deliver
    notice(:job_validated) and redirect_to job_path(@job)
  end

  private
  def load_from_session
    error(:job_unknown) and redirect_to :root unless session[:job_id]
    @job = Job.find session[:job_id]
  end

  def load_from_params
    @job = Job.find params[:id]
  end
end
