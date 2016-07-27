class TimeLimit < ApplicationRecord
  belongs_to :action, inverse_of: :time_limits
  belongs_to :unit
  belongs_to :inspection
  has_one :over_the_time_limit, inverse_of: :time_limit, dependent: :destroy
  accepts_nested_attributes_for :over_the_time_limit

end
