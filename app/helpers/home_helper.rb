module HomeHelper
  def maximum_host_count( facilities )
    return facilities.max do |f, g|
      f.hosts.count <=> g.hosts.count
    end.hosts.count
  end

  def rows_for_facility( facility )
    return facility.hosts.count + facility.hosts.sum { |h| h.appointments.count }
  end

  def rows_for_host( host )
    return host.appointments.count
  end

  def rows_for( object )
    return rows_for_facility(object) if object.kind_of? Facility
    return rows_for_host(object) if object.kind_of? Host
  end
end
