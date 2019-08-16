json.extract! employee, :id, :cpf, :name, :company, :created_at, :updated_at
json.url employee_url(employee, format: :json)
