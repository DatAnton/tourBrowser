module ToursAndUsersHelper
  def is_saved?(tour)
    current_user.tours.include?(tour)
  end
end
