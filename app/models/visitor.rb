class Visitor < ApplicationRecord
  #belongs_to :company
  has_many :hosts, through: :appointments
end
