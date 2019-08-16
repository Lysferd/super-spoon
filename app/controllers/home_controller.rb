class HomeController < ApplicationController
  def index
  end

  def dev
    @facilities = Facility.all
    @companies = Company.all
  end
end
