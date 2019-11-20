class Company < ApplicationRecord
  has_many :employees

  before_save do
    name.upcase!
  end
end
