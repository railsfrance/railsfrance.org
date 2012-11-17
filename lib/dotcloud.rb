module Dotcloud
  module_function
  def env
    @env ||= JSON.parse(File.read(Rails.root.join('environment.json')))
  end
end
