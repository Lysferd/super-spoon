class Resident < ApplicationRecord
  belongs_to :facility
  has_many :appointments, foreign_key: :host_id
  has_many :visitors, class_name: :Employee, through: :appointments

  before_save do
    name.upcase!
    number.upcase!
  end
end
