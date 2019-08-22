class StaticPagesController < ApplicationController
  def about
    @tours = Tour.all.reverse.take(3)
  end

  def hotel_info

  end
end
