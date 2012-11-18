class JobsController < ApplicationController
  include Messages

  before_filter :load_from_session, only: [:preview, :confirm, :update, :destroy]
  before_filter :load_from_params, only: :show

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

  def preview
    render :show
  end

  def edit
    redirect_to :root and return unless
      @job = Job.with_state(:activated).where(token: params[:token]).first
    session[:job_id] = @job.id
    render :new
  end

  def update
    if @job.update_attributes(params[:job])
      notice(:job_updated)
      redirect_to(@job)
    else
      error(:job_not_updated, {now: true})
      render :new
    end
  end

  def confirm
    @job.confirm!
    ContactMailer.confirm_job(@job).deliver
    session[:job_id] = nil
    notice(:job_confirmation) and redirect_to :root
  end

  def validate
    redirect_to :root and return unless @job = Job.with_state(:confirmed).where(token: params[:token]).first
    @job.activate!
    ContactMailer.valid_job(@job).deliver
    notice(:job_validated) and redirect_to job_path(@job)
  end

  def destroy
    if @job.soft_delete
      notice(:job_soft_deleted)
    else
      error(:job_not_soft_deleted)
    end
    redirect_to jobs_path
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
