module Dispatcher
  extend ActiveSupport::Concern

  module ClassMethods
    def dispatchable(*args)
      class_eval <<-METHOD
         def self.dispatch(method)
           params = #{args}
           final = false

           if i = params.index { |o| o.is_a?(Hash) }
             final = (params.delete_at(i).try(:key?, :final) == true)
           end

           params.each do |obj|
           dest = "\#\{self\}::\#\{obj.to_s.camelize\}".constantize
           final == true ? dest.send(method) : dest.send(:dispatch, method)
         end
       end
      METHOD
    end
  end
end
