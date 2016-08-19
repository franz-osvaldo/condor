class Product < ApplicationRecord
  belongs_to :product_unit
  has_many :incoming_details
  has_many :incoming_movements, through: :incoming_details
  has_many :outgoing_details
  has_many :outgoing_movements, through: :outgoing_details
  has_many :product_quantities
  has_attached_file :image_product, styles: { medium: '350x216>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image_product, content_type: /\Aimage\/.*\Z/

  after_initialize :set_defaults
  before_save :set_values
  private
    def set_values
      self.specification.blank? ? self.specification = 'No especificado' : self.specification
      self.procurement_lead_time.nil? ? self.procurement_lead_time = 0 : self.procurement_lead_time
      self.maximum.nil? ? self.maximum = 0 : self.maximum
      self.minimum.nil? ? self.minimum = 0 : self.minimum
      self.optimum.nil? ? self.optimum = 0 : self.optimum
    end
    def set_defaults
      self.specification == 'No especificado' ? self.specification = nil : self.specification
      self.procurement_lead_time == 0 ? self.procurement_lead_time = nil : self.procurement_lead_time
      self.maximum == 0 ? self.maximum = nil : self.maximum
      self.minimum == 0 ? self.minimum = nil : self.minimum
      self.optimum == 0 ? self.optimum =nil : self.optimum
    end


end



