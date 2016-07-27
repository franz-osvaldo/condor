class Priority < ApplicationRecord
  belongs_to :scheduled_inspection
  belongs_to :inspection
end
