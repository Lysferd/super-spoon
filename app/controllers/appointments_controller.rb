class AppointmentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.all
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
    @residents = Resident.all
    @visitors = Employee.all + Visitor.all
  end

  # GET /appointments/1/edit
  def edit
    @residents = Resident.all
    @visitors = Employee.all + Visitor.all
  end

  # POST /appointments
  # POST /appointments.json
  def create
    params = appointment_params
    params[:created_by_id] = current_user.id
    params[:visitor_id], params[:visitor_type] = params[:visitor].split ?#
    params.delete :visitor

    @appointment = Appointment.new(params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Visita cadastrada com sucesso.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    params = appointment_params
    params[:updated_by_id] = current_user.id
    params[:visitor_id], params[:visitor_type] = params[:visitor].split ?#
    params.delete :visitor

    respond_to do |format|
      if @appointment.update(params)
        format.html { redirect_to @appointment, notice: 'Visita atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Visita descadastrada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:description, :host_id, :visitor)
    end
end
