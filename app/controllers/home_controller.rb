class HomeController < ApplicationController
  def index
    @facilities = Facility.all
    @visitors = Visitor.all

    if !@facility
      @facility = Facility.find_by(id: params[:facility].to_i)
    end

    if !@visitor
      @visitor = Visitor.find_by(cpf: params[:cpf])
      if !@visitor && params[:name]
        @visitor = Visitor.new(cpf: params[:cpf], name: params[:name], company: params[:company])
      end
    end

    if @visitor
      @appointment = Appointment.new
    end

    if @visitor && @appointment && params[:date] && params[:host]
      @appointment.date = DateTime.parse(params[:date] +'T'+ params[:time])
      @appointment.host_id = params[:host]
      @appointment.description = params[:description]
      if @visitor.id
        @appointment.visitor_id = @visitor.id
      else
        @visitor.save
	@appointment.visitor_id = @visitor.id
      end
      if @appointment.save
        redirect_to(@appointment)
      else
        redirect_to root_path
      end
    end
  end
  def next
    respond_to do |format|
      format.html
    end
  end

  def dev
    @facilities = Facility.all
    @companies = Company.all
  end
end
