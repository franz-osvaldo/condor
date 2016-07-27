class Task < ApplicationRecord
  belongs_to :system
  has_many :procedures
  has_many :actions, through: :procedures, inverse_of: :tasks
end


