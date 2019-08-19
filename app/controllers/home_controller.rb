require 'cpf_gen'

class HomeController < ApplicationController

  def index

    if params[:purpose] == 'particular'
      @visitors = Visitor.all
    else
      @visitors = Employee.all
    end

    if params[:facility]
      params[:facility_id] = params[:facility][:id]
    end

    if params[:facility_id] #!@facility
      @facility = Facility.find_by(id: params[:facility_id])
    end

    @valid_cpf = CPF.verify params[:cpf] if params[:cpf]

    if !@visitor #and @valid_cpf
      if params[:purpose] == 'particular'
        @visitor = Visitor.find_by( cpf: params[:cpf] )
      else
        @visitor = Employee.find_by(cpf: params[:cpf])
      end

      if !@visitor && params[:name]
        if params[:purpose] == 'particular'
          @visitor = Visitor.new(cpf: params[:cpf], name: params[:name])
        else
          params[:company_id] = params[:company][:id] if params[:company]
          @visitor = Employee.new(cpf: params[:cpf], name: params[:name], company_id: params[:company_id])
        end
      end
    end

    if @visitor
      @appointment = Appointment.new
    end

    if @visitor && @appointment && params[:date] && params[:host]
      @appointment.date = DateTime.parse(params[:date] +'T'+ params[:time])
      @appointment.host_id = params[:host]
      @appointment.description = params[:description]
      @appointment.professional = params[:purpose] == 'professional'
      @appointment.visitor_type = @visitor.class.name

      
      if @visitor.id
        @appointment.visitor_id = @visitor.id
      else
        @visitor.save
	      @appointment.visitor_id = @visitor.id
      end

      if @appointment.save
        redirect_to root_path, notice: 'Visita agendada com sucesso!'
      end
    end
  end

  def dev
    @facilities = Facility.all
    @companies = Company.all
  end

end
