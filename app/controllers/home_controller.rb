class HomeController < ApplicationController
  def index
    @facilities = Facility.all
    if params[:facility].present?
#      flash[:notice] = "Building Selected"
#      redirect_to "/dev"
#       render 'visitor_form'
       @facility = params[:facility]
    end
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
