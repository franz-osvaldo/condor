class ProductQuantity < ApplicationRecord
  belongs_to :product

  def self.add_quantity(v_product_id, v_expiration_date, v_description, v_quantity)
    record = self.where('product_id = ? AND expiration_date = ?', v_product_id, v_expiration_date).first
    # Si el producto no existe -> nuevo registro
    if record.nil?
      self.create(:product_id => v_product_id,
                  :description => v_description,
                  :quantity => v_quantity,
                  :expiration_date => v_expiration_date)
    # Si el producto no existe -> actualizamos el registro
    else
      record.update(:quantity => record.quantity + v_quantity)
    end
  end

  def self.subtract_quantity(v_product_id, v_expiration_date, v_quantity)
    record = ProductQuantity.where('product_id = ? AND expiration_date = ?', v_product_id, v_expiration_date).first
    record.update(:quantity=> record.quantity - v_quantity)
  end
end
