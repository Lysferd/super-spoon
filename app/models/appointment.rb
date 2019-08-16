class Appointment < ApplicationRecord
  belongs_to :host, class_name: :Resident
  belongs_to :visitor, class_name: :Employee, polymorphic: true
end
