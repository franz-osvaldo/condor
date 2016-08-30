class Part < ApplicationRecord
  belongs_to :component
  has_many :time_details
  has_many :fleets, through: :time_details
  has_many :tbos

end
