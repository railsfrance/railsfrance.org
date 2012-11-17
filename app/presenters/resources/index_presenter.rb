class Resources::IndexPresenter
  LIMIT = 5

  def workers
    @workers ||= Worker.all
  end

  def guides
    @guides ||= Guide.all
  end
end
