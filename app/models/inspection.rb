class Inspection < ApplicationRecord
  has_many :priorities
  has_many :scheduled_inspections, through: :priorities
end

