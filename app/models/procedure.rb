class Procedure < ApplicationRecord
  belongs_to :task, inverse_of: :procedures
  belongs_to :action, inverse_of: :procedures
end
