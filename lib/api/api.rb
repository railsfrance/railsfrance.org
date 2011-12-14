module Api
  autoload :Parisrb, 'api/parisrb'
  autoload :Vendors, 'api/vendors'
  autoload :Task, 'api/task'
  autoload :Dispatcher, 'api/dispatcher'
  include Dispatcher

  dispatchable :parisrb

end
