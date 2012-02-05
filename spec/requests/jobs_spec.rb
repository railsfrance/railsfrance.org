require 'spec_helper'

describe JobsController do

  describe "#index" do
    before(:each) do
      Factory(:job, state: 'activated')
      visit jobs_path
    end
    let(:job) { Job.first }

    it "should display the page" do
      current_path.should == jobs_path
    end
    it "should display activated jobs" do
      page.should have_content(job.title)
    end
  end

  describe "#new" do
    before(:each) { visit new_job_path }

    it "should display the page" do
      current_path.should == new_job_path
    end
  end

  describe "#show" do
    context "with an activated job" do
      before(:each) do
        job = Factory(:job, state: 'activated')
        visit job_path(job)
      end

      let(:job) { Job.first }

      it "should display the page" do
        current_path.should == job_path(job)
      end
      it "should display job information" do
        page.should have_content(job.title)
      end
    end

    context "with an non activated job" do
      before(:each) do
        job = Factory(:job)
        visit job_path(job)
      end

      let(:job) { Job.first }

      it "should display the page" do
        current_path.should == root_path
      end
      it "should display job information" do
        page.should have_content(I18n.t('messages.job_not_activated'))
      end
    end
  end

  describe "job creation workflow #create, #preview, #confirm" do
    it "should create a job" do
      job = Factory.build :job
      visit new_job_path

      within("#new_job") do
        fill_in "job_company", with: job.company
        fill_in "job_email", with: job.email
        fill_in "job_title", with: job.title
        fill_in "job_street", with: job.street
        fill_in "job_city", with: job.city
        fill_in "job_postal_code", with: job.postal_code
        fill_in "job_description", with: job.description
        check "job_cdi"
      end
      click_on "job_form_submit"
      Job.last.title.should eql job.title
      current_path.should == preview_jobs_path
      click_on 'Confirmer'
      ActionMailer::Base.deliveries.last.to.should == [job.email]
      current_path.should == root_path
      page.should have_content I18n.t('messages.job_confirmation')
    end
  end

  pending "#edit"
  pending "#update"
  pending "#validate"
end
