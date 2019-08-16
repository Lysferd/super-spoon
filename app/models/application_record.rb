class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  public
  def created_by
    User.find(created_by_id) or 'unknown'
  end

  def updated_by
    User.find(updated_by_id) or 'unknown'
  end

  def updated?
    updated_at and updated_by_id
  end
end
