module Api
  class Task

    def self.synchronize_from_api
      Api.dispatch(:synchronize_from_api)
    end

  end
end
