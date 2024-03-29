class FacilitiesController < ApplicationController
  load_and_authorize_resource
  before_action :set_facility, only: [:show, :edit, :update, :destroy]

  # GET /facilities
  # GET /facilities.json
  def index
    @facilities = Facility.all
  end

  # GET /facilities/1
  # GET /facilities/1.json
  def show
  end

  # GET /facilities/new
  def new
    @facility = Facility.new
  end

  # GET /facilities/1/edit
  def edit
  end

  # POST /facilities
  # POST /facilities.json
  def create
    params = facility_params
    params[:created_by_id] = current_user.id

    @facility = Facility.new(params)

    respond_to do |format|
      if @facility.save
        format.html { redirect_to @facility, notice: 'Prédio cadastrado com sucesso.' }
        format.json { render :show, status: :created, location: @facility }
      else
        format.html { render :new }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facilities/1
  # PATCH/PUT /facilities/1.json
  def update
    params = facility_params
    params[:updated_by_id] = current_user.id

    respond_to do |format|
      if @facility.update(params)
        format.html { redirect_to @facility, notice: 'Prédio atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @facility }
      else
        format.html { render :edit }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facilities/1
  # DELETE /facilities/1.json
  def destroy
    
    respond_to do |format|
      if @facility.residents.empty?
        @facility.destroy
        format.html { redirect_to facilities_url, notice: 'Prédio descadastrado.' }
        format.json { head :no_content }
      else
        flash.now[:alert] = 'Não é possivel apagar um prédio enquanto houverem moradores cadastrados no mesmo.'
        format.html { render :show }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility
      @facility = Facility.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def facility_params
      params.require(:facility).permit(:name)
    end
end
