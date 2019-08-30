class VisitorsController < ApplicationController
  before_action :set_visitor, only: [:show, :edit, :update, :destroy]

  # GET /visitors
  # GET /visitors.json
  def index
    @visitors = Visitor.all
  end

  # GET /visitors/1
  # GET /visitors/1.json
  def show
  end

  # GET /visitors/new
  def new
    @visitor = Visitor.new
  end

  # GET /visitors/1/edit
  def edit
  end

  # POST /visitors
  # POST /visitors.json
  def create
    params = visitor_params
    params[:created_by_id] = current_user.id

    @visitor = Visitor.new(params)

    respond_to do |format|
      if @visitor.save
        format.html { redirect_to @visitor, notice: 'Visitante cadastrado com sucesso.' }
        format.json { render :show, status: :created, location: @visitor }
      else
        format.html { render :new }
        format.json { render json: @visitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visitors/1
  # PATCH/PUT /visitors/1.json
  def update
    params = visitor_params
    params[:updated_by_id] = current_user.id

    respond_to do |format|
      if @visitor.update(params)
        format.html { redirect_to @visitor, notice: 'Visitante atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @visitor }
      else
        format.html { render :edit }
        format.json { render json: @visitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visitors/1
  # DELETE /visitors/1.json
  def destroy

    respond_to do |format|
      if @visitor.appointments.empty?
        @visitor.destroy
        format.html { redirect_to visitors_url, notice: 'Visitante descadastrado.' }
        format.json { head :no_content }
      else
        flash.now[:alert] = 'Não é possivel apagar um visitante enquanto ainda houverem visitas marcadas.'
        format.html { render :show }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visitor
      @visitor = Visitor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def visitor_params
      params.require(:visitor).permit(:name, :cpf)
    end
end
