class Users::IndexPresenter
  extend ActiveSupport::Memoizable

  def members_count
    User.all.size
  end

  memoize :members_count
end
