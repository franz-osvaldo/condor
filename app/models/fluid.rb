class Fluid < ApplicationRecord
  belongs_to :part
  belongs_to :condition
  belongs_to :unit
end
