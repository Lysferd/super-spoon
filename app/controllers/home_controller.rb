require 'cpf_gen'

class HomeController < ApplicationController

  def index

    if params[:cpf]
      p CPF::verify params[:cpf]
    end


    @facilities = Facility.all

    if params[:purpose] == 'particular'
      @visitors = Visitor.all
    else
      @visitors = Employee.all
    end

    if !@facility
      @facility = Facility.find_by(id: params[:facility].to_i)
    end

    if !@visitor and params[:cpf]
      unless CPF::verify params[:cpf]
        #render js: "alert('CPF Inválido');"
      end

      if params[:purpose] == 'particular'
        @visitor = Visitor.find_by( cpf: params[:cpf] )
      else
        @visitor = Employee.find_by(cpf: params[:cpf])
      end

      if !@visitor && params[:name]
        if params[:purpose] == 'particular'
          @visitor = Visitor.new(cpf: params[:cpf], name: params[:name])
        else
          @visitor = Empoyee.new(cpf: params[:cpf], name: params[:name],
                                 company: params[:company])
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
        redirect_to(@appointment)
      else
        redirect_to root_path
      end
    end
  end

  def dev
    @facilities = Facility.all
    @companies = Company.all
  end

end
