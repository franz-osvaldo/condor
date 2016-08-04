class IncomingDetail < ApplicationRecord
  belongs_to :incoming_movement
  belongs_to :product
  after_create :set_product_quantity

  # Luego de que la entrada en el almacén se concreta establecemos las cantidades totales
  def set_product_quantity
    ProductQuantity.add_quantity(self.product_id, self.expiration_date, self.product.description, self.quantity)
  end
end



