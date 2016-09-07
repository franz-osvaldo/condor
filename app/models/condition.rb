class Condition < ApplicationRecord
  has_many :tbos
  has_many :fluids
end

