class AlertLifeLimit < ApplicationRecord
  belongs_to :life_time_limit
  belongs_to :fleet
end
