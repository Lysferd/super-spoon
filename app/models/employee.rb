class Employee < ApplicationRecord
  belongs_to :company
  has_many :appointments, foreign_key: :visitor_id, as: :visitor
  has_many :hosts, class_name: :Resident, through: :appointments

  public def id_with_type
    return self.id.to_s + ?# + self.class.to_s
  end
end
