class Visitor < ApplicationRecord
  has_many :appointments, foreign_key: :visitor_id, as: :visitor
  has_many :hosts, class_name: :Resident, through: :appointments
end
