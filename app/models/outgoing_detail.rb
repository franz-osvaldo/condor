class OutgoingDetail < ApplicationRecord
  belongs_to :product
  belongs_to :outgoing_movement
  after_create :set_total_quantity

  # Luego de que la salida del almacén se concreta establecemos las cantidades totales
  def set_total_quantity
    ProductQuantity.subtract_quantity(self.product_id, self.expiration_date, self.quantity)
  end
end
