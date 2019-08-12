class HomeController < ApplicationController
  def index
    @facilities = Facility.all
  end
  def next
    respond_to do |format|
      format.html
    end
  end

  def dev
    @facilities = Facility.all
  end
end
