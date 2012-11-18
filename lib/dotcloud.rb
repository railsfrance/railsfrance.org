module Dotcloud
  module_function
  def env
    @env ||= JSON.parse(File.read('/home/dotcloud/environment.json'))
  end
end
