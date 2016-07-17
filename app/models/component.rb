class Component < ApplicationRecord
  belongs_to :system
  has_many :parts
end
