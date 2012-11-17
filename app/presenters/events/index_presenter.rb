class Events::IndexPresenter
  def incoming_events
    @incoming_events ||= Event.where('date >= ?', Time.now).size
  end
end
