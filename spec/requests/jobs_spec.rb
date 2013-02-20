require 'spec_helper'

describe JobsController do

  describe "#index" do
    let!(:job) { Factory(:job, state: 'activated') }

    before(:each) { visit jobs_path }

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
      let!(:job) { Factory(:job, state: 'activated') }
      before(:each) { visit job_path(job) }

      it "should display the page" do
        current_path.should == job_path(job)
      end
      it "should display job information" do
        page.should have_content(job.title)
      end
    end

    context "with an non activated job" do
      let!(:job) { Factory(:job) }
      before(:each) { visit job_path(job) }

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

  describe "#edit, #update, #destroy" do
    context "with a valid job" do
      let!(:job) { Factory(:job, state: 'activated', token: 'my_secure_token') }
      before(:each) { visit edit_job_path(token: job.token) }

      it "should display the page" do
        current_path.should == edit_job_path(token: job.token)
      end

      it "should have the job datas" do
        find_field('job_title').value.should eql job.title
        find_field('job_company').value.should eql job.company
        find_field('job_street').value.should eql job.street
        find_field('job_city').value.should eql job.city
        find_field('job_postal_code').value.should eql job.postal_code
        find_field('job_description').value.should eql job.description
      end

      it "should update jobs attributes" do
        fill_in "job_company", with: ''
        click_on "job_form_submit"

        current_path.should eql job_path(job)
        page.should have_content I18n.t('messages.job_not_updated')
        job.reload.company.should eql job.company
      end

      it "should not allow email update" do
        page.should_not have_selector('input#job_email')
      end

      it "should have a link to destroy the job" do
        click_on "Supprimer"
        job.soft_deleted? should be_true
      end
    end

    context "with an invalid state" do
      let!(:job) { Factory(:job, state: 'confirmed', token: 'my_secure_token') }
      before(:each) { visit edit_job_path(token: job.token) }
      it "should redirect to root_path" do
        current_path.should == root_path
      end
    end

    context "with an invalid token" do
      let!(:job) { Factory(:job, state: 'activated', token: 'my_secure_token') }
      before(:each) { visit edit_job_path(token: '123') }
      it "should display redirect to root_path" do
        current_path.should == root_path
      end
    end
  end

  describe "#validate" do
    context "with a valid job" do
      let!(:job) { Factory(:job, state: 'confirmed', token: 'my_secure_token') }
      let(:mail) { double('contact_mailer').as_null_object }

      it "should activate the job" do
        ContactMailer.should_receive(:valid_job)
          .and_return(mail)

        Job.any_instance
          .should_receive(:notify_observers) {|record| record.id.should eql(job.id) }
          .with(:after_activation)
          .and_return

        visit validate_job_path(token: job.token)
        job.reload.state.should eql 'activated'
        current_path.should eql job_path(job)
        page.should have_content I18n.t('messages.job_validated')
      end
    end

    context "with an invalid job#state" do
      it "should redirect to root" do
        job = Factory(:job, state: 'pending', token: 'my_secure_token')
        visit validate_job_path(token: job.token)
        current_path.should eql root_path
      end
    end

    context "with an invalid job#token" do
      it "should redirect to root" do
        job = Factory(:job, state: 'confirmed', token: 'my_secure_token')
        visit validate_job_path(token: 'wrong token')
        current_path.should eql root_path
      end
    end
  end

end
