class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, uniqueness: true

  # Roles:
  # 0: dev: allow all
  # 1: admin: allow all
  # 2: supervisor: reports only
  # 3: operator: view reports
  # 4: manager: create resident users
  # 5: resident: schedules visits
  public
  def is_dev?
    return self.role == 0
  end

  def role?
    return case self.role
      when 0 then :dev
      when 1 then :admin
      when 2 then :supervisor
      when 3 then :operator
      when 4 then :manager
      when 5 then :resident
    end
  end
end
