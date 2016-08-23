class Task < ApplicationRecord
  belongs_to :system
  has_many :procedures
  has_many :actions, through: :procedures, inverse_of: :tasks
  has_many :task_tools
  has_many :tools, through: :task_tools
  has_many :task_products
  has_many :products, through: :task_products
end


