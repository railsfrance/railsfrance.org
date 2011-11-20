module Api
  autoload :Parisrb, 'api/parisrb'
  autoload :Vendors, 'api/vendors'
  autoload :Task, 'api/task'
  autoload :Dispatcher, 'api/dispatcher'
  autoload :Hash, 'api/core_ext/hash'
  include Dispatcher

  dispatchable :parisrb

end
