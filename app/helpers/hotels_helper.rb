module HotelsHelper
  def owner_exists(owner_id)
    User.where(id: owner_id).first
  end
end
