class System < ApplicationRecord
  belongs_to :aircraft
  has_many :components
end
