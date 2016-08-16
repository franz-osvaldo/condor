class User < ApplicationRecord
  has_many :borrowed_tools
  has_many :returned_tools

end

