class OutgoingDetail < ApplicationRecord
  belongs_to :product
  belongs_to :outgoing_movement

  validates :quantity, presence: true
  validates :quantity, numericality: {greater_than: 0}

  after_create :update_stock

  # Luego de que la salida del almacén se concreta establecemos las cantidades totales
  def update_stock
    ProductQuantity.take_out_product(self.quantity, self.product_quantity_id)
  end
end
