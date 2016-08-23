class System < ApplicationRecord
  belongs_to :aircraft
  has_many :components
  has_many :scheduled_inspections
  has_many :tasks
end
