class Facility < ApplicationRecord
  has_many :residents

  before_save do
    name.upcase!
  end

  public def appointments
    return residents.map { |r| r.appointments }.flatten
  end
end
