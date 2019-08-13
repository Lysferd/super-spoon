class HomeController < ApplicationController
  def index
    @facilities = Facility.all
    @visitors = Visitor.all
    if params[:facility]
      @facility = Facility.find_by(id: params[:facility].to_i)
    end
    if params[:cpf]
      cpf = params[:cpf]
      @visit = Visitor.find_by(cpf: cpf)
    end
    if params[:name] && params[:cpf] && !@visit
      @visit = Visitor.new(name: params[:name], cpf: params[:cpf], company: params[:company])
    end
    if @visit
      @appointment = Appointment.new
      if @visit.id
        @appointment.visitor_id = @visit.id
      end
    end
    if @visit && @appointment && params[:date] && params[:host]
      @appointment.date = params[:date]
      @appointment.host_id = params[:host]
      @appointment.save
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
