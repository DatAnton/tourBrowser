module ApplicationHelper

  def is_opp_hotels?
    (current_user.count_of_hotels - current_user.hotels.length) > 0
  end
end
