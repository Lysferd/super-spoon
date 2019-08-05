class Host < ApplicationRecord
  belongs_to :facility
  has_many :appointments
  has_many :visitors, through: :appointments
end
