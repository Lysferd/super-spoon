module HomeHelper
  def maximum_resident_count( facilities )
    return facilities.max do |f, g|
      f.residents.count <=> g.residents.count
    end.residents.count
  end

  def rows_for_facility( facility )
    return facility.residents.count + facility.residents.sum { |h| h.appointments.count }
  end

  def rows_for_company( company )
    return company.employees.count + company.employees.sum { |e| e.appointments.count }
  end

  def rows_for_resident( resident )
    return resident.appointments.count
  end

  def rows_for_employee( employee )
    return employee.appointments.count
  end

  def rows_for( object )
    return rows_for_facility(object) if object.kind_of? Facility
    return rows_for_company(object) if object.kind_of? Company
    return rows_for_resident(object) if object.kind_of? Resident
    return rows_for_employee(object) if object.kind_of? Employee
  end
end
