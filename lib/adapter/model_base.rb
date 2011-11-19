module Adapter
  module Model

    class Base
      attr_accessor :model

      def initialize(model)
        @model = model
      end
    end

  end
end
