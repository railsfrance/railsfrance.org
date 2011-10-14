module Sortable
  def attr_sortable(*options)
    @attr_sortable = options
    class << self; attr_reader :attr_sortable; end;
  end
end
