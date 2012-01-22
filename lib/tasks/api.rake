namespace :api do
  desc "Updates all api adapters"
  task :update => :environment do
    Api::Task.synchronize_from_api
  end
end
