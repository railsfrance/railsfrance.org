class Users::IndexPresenter
  def members_count
    @members_count ||= User.all.size
  end
end
