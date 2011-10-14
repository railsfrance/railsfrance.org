class Resources::IndexPresenter
  extend ActiveSupport::Memoizable
  LIMIT = 5

  def workers
    Worker.all
  end
  
  def guides
    Guide.all
  end

  memoize :workers, :guides
end
