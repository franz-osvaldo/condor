class TaskProduct < ApplicationRecord
  belongs_to :task
  belongs_to :product
end
