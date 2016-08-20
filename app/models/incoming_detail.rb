class IncomingDetail < ApplicationRecord
  belongs_to :incoming_movement
  belongs_to :product

  validates_with Location
  validates :quantity, presence: true
  validates :quantity, numericality: {greater_than: 0}
  validates :aisle, :section, :level, :position, presence: true


  before_save :set_expiration_date
  before_save :set_serial_number
  after_create :update_stock

  # Luego de que la entrada en el almacén se concreta establecemos las cantidades totales
  private
  def set_expiration_date
    if self.expiration_date.nil?
      self.expiration_date = '3000-01-01'
    end
  end

  def set_serial_number
    if self.serial_number.empty?
      self.serial_number = 'ND'
    end
  end

  def update_stock
    ProductQuantity.enter_product(self.id)
  end
end



