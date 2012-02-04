namespace :test do
  task :travis do
      puts "Starting to run rake test..."
      system("export DISPLAY=:99.0 && bundle exec rake test spec")
      raise "rake test failed!" unless $?.exitstatus == 0
  end
end
