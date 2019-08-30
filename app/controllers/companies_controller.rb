class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    params = company_params
    params[:created_by_id] = current_user.id

    @company = Company.new(params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Nova empresa cadastrada com sucesso.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    params = company_params
    params[:updated_by_id] = current_user.id

    respond_to do |format|
      if @company.update(params)
        format.html { redirect_to @company, notice: 'Empresa atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    respond_to do |format|
      if @company.employees.empty?
        @company.destroy
        format.html { redirect_to companies_url, notice: 'Empresa descadastrada.' }
        format.json { head :no_content }
      else
        flash.now[:alert] = 'Não é possivel apagar uma empresa enquanto houverem funcionários cadastrados na mesma.'
        format.html { render :show }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :cnpj)
    end
end
