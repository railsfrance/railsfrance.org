require 'test_helper'

# TODO
# - Test image upload

class JobsControllerTest < ActionController::TestCase
  tests JobsController
  include Devise::TestHelpers

  setup do
    @job = Factory(:job)
  end

  test 'index' do
    get :index

    assert_not_nil assigns(:jobs)
    assert_response :success
    assert_template 'jobs/index'
  end

  test 'new' do
    get :new

    assert_not_nil assigns(:job)
    assert_response :success
    assert_template 'jobs/new'
  end

  test 'show' do
    @job.update_attribute(:state, "activated")
    get :show, :id => @job.id

    assert_not_nil assigns(:job)
    assert_response :success
    assert_template 'jobs/show'
  end

  test 'create' do
    assert_difference('Job.count') do
      post :create, :job => Factory.build(:job).attributes
    end
    assert_not_nil session[:job_id]
    assert_redirected_to preview_jobs_path
  end

  test 'edit' do
    @job = Factory(:job, :state => "activated", :token => "token")
    get :edit, :token => @job.token

    assert_not_nil assigns(:job)
    assert_response :success
    assert_template 'jobs/new'
  end

  test 'preview' do
    session[:job_id] = @job.id

    get :preview
    assert_response :success
    assert_template 'jobs/show'
  end

  test 'confirm' do
    session[:job_id] = @job.id

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      get :confirm
    end

    # debugger
    assert Job.find(@job.id).confirmed?
    assert session[:job_id].nil?
    assert_redirected_to root_path
  end

  test 'validate' do
    @job = Factory(:job, :state => 'confirmed', :token => 'token')

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      get :validate, :token => @job.token
    end

    # debugger
    assert Job.find(@job.id).activated?
    assert_redirected_to job_path(@job)
  end
end
