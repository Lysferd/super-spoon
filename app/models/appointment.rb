class Appointment < ApplicationRecord
  belongs_to :host
  belongs_to :visitor

  def verbose
    return self.description + ' with ' + self.visitor.name
  end
end
