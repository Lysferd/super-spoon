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

  #   Parameters: {"utf8"=>"✓",
  #               "authenticity_token"=>"HASH",
  #               "filters"=>["facility"],
  #               "facility"=>{"id"=>"1"},
  #               "resident"=>{"id"=>""},
  #               "cpf"=>"",
  #               "commit"=>"Buscar"}
  def records
    # If filter parameters have been set, start the filtering.
    if params[:filters]
      appointments = [ ]

      # If a facility has been filtered, then filter by all residents
      if params[:filters].include? 'facility'
        appointments.concat Facility.find_by_id(params[:facility][:id]).appointments
      end

      # If a host has been selected, add it to the filtering
      if params[:filters].include? 'resident'
        appointments.concat Resident.find_by_id(params[:resident][:id]).appointments
      end

      # This one is tricky. Can be Employee or Visitor, which can share the IDs.
      if params[:filters].include? 'visitor'
      end
      
      @appointments = appointments.uniq # might be nil

    end
  end

  def dev
    @facilities = Facility.all
    @companies = Company.all
  end

end
