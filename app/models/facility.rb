class Facility < ApplicationRecord
  has_many :residents

  public def appointments
    return residents.map { |r| r.appointments }.flatten
  end
end
