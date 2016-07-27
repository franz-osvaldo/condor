class OverTheTimeLimit < ApplicationRecord
  belongs_to :time_limit, inverse_of: :over_the_time_limit
  belongs_to :unit
end
