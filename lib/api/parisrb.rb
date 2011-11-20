module Api
  module Parisrb
    autoload :Base, 'api/parisrb/base'
    autoload :EventAdapter, 'api/parisrb/event_adapter'
    include Dispatcher

    dispatchable :event_adapter, final: true
  end
end
