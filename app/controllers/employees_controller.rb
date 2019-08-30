class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    @companies = Company.all
  end

  # GET /employees/1/edit
  def edit
    @companies = Company.all
  end

  # POST /employees
  # POST /employees.json
  def create
    params = employee_params
    params[:created_by_id] = current_user.id

    @employee = Employee.new(params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Funcionário cadastrado com sucesso.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    params = employee_params
    params[:updated_by_id] = current_user.id

    respond_to do |format|
      if @employee.update(params)
        format.html { redirect_to @employee, notice: 'Funcionário atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy

    respond_to do |format|
      if @employee.appointments.empty?
        @employee.destroy
        format.html { redirect_to employees_url, notice: 'Funcionário descadastrado.' }
        format.json { head :no_content }
      else
        flash.now[:alert] = 'Não é possivel apagar um funcionário enquanto ainda houverem visitas cadastradas.'
        format.html { render :show }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:cpf, :name, :company_id)
    end
end
