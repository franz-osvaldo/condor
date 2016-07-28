class Fleet < ApplicationRecord
  belongs_to :aircraft
  has_many :flights
end
