class Tool < ApplicationRecord
  has_many :incoming_quantities
  has_many :incoming_tools, through: :incoming_quantities
  has_many :tool_quantities
  has_many :outgoing_quantities
  has_many :outgoing_tools, through: :outgoing_quantities

  validates :part_number, presence: true
  validates :description, presence: true
  validates :part_number, uniqueness: {scope: :description, case_sensitive: false}

  has_attached_file :image, styles: { medium: '348x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
