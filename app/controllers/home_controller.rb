class HomeController < ApplicationController
  def index
  end

  def dev
    @facilities = Facility.all
  end
end
