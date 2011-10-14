class Events::IndexPresenter
  extend ActiveSupport::Memoizable

  def incoming_events
    Event.where('date >= ?', Time.now).size
  end

  memoize :incoming_events
end
