class ResidentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_resident, only: [:show, :edit, :update, :destroy]

  # GET /residents
  # GET /residents.json
  def index
    @residents = Resident.all
  end

  # GET /residents/1
  # GET /residents/1.json
  def show
  end

  # GET /residents/new
  def new
    @resident = Resident.new
    @facilities = Facility.all
  end

  # GET /residents/1/edit
  def edit
    @facilities = Facility.all
  end

  # POST /residents
  # POST /residents.json
  def create
    params = resident_params
    params[:created_by_id] = current_user.id

    @resident = Resident.new(params)

    respond_to do |format|
      if @resident.save
        format.html { redirect_to @resident, notice: 'Novo morador cadastrado com sucesso.' }
        format.json { render :show, status: :created, location: @resident }
      else
        format.html { render :new }
        format.json { render json: @resident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /residents/1
  # PATCH/PUT /residents/1.json
  def update
    params = resident_params
    params[:updated_by_id] = current_user.id

    respond_to do |format|
      if @resident.update(params)
        format.html { redirect_to @resident, notice: 'Morador atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @resident }
      else
        format.html { render :edit }
        format.json { render json: @resident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /residents/1
  # DELETE /residents/1.json
  def destroy

    respond_to do |format|
      if @resident.appointments.empty?
        @resident.destroy
        format.html { redirect_to residents_url, notice: 'Morador descadastrado.' }
        format.json { head :no_content }
      else
        flash.now[:alert] = 'Não é possivel apagar um morador enquanto ainda houverem visitas cadastradas.'
        format.html { render :show }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resident
      @resident = Resident.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resident_params
      params.require(:resident).permit(:name, :facility_id, :number)
    end
end
