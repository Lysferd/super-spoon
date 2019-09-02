class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, uniqueness: true

  public def is_dev?
    return self.id == 1
  end
end
