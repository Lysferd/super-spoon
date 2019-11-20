class Visitor < ApplicationRecord
  has_many :appointments, foreign_key: :visitor_id, as: :visitor
  has_many :hosts, class_name: :Resident, through: :appointments

  before_save do
    name.upcase!
    plate.upcase!
  end

  public def id_with_type
    return self.id.to_s + ?# + self.class.to_s
  end
end
