class ProductQuantity < ApplicationRecord
  belongs_to :product


  def self.enter_product(v_incoming_detail_id)
    incoming_detail = IncomingDetail.find(v_incoming_detail_id)
    if self.update_quantity?(incoming_detail.product.part_number,
                             incoming_detail.product.description,
                             incoming_detail.serial_number,
                             incoming_detail.expiration_date,
                             incoming_detail.aisle,
                             incoming_detail.section,
                             incoming_detail.level,
                             incoming_detail.position)
      product = self.get_product(incoming_detail.product.part_number,
                       incoming_detail.product.description,
                       incoming_detail.serial_number,
                       incoming_detail.expiration_date,
                       incoming_detail.aisle,
                       incoming_detail.section,
                       incoming_detail.level,
                       incoming_detail.position)
      product.update(:quantity => product.quantity + incoming_detail.quantity)
    else
      self.create(:product_id => incoming_detail.product_id,
                  :quantity => incoming_detail.quantity,
                  :expiration_date => incoming_detail.expiration_date,
                  :aisle => incoming_detail.aisle,
                  :section => incoming_detail.section,
                  :level => incoming_detail.level,
                  :position => incoming_detail.position,
                  :serial_number => incoming_detail.serial_number,
                  :description => incoming_detail.product.description,
                  :part_number => incoming_detail.product.part_number)
    end
  end

  def self.get_product(v_part_number, v_description, v_serial_number, v_expiration_date, v_aisle, v_section, v_level, v_position)
    ProductQuantity.where('part_number = ?     AND
                           description = ?     AND
                           serial_number = ?   AND
                           expiration_date = ? AND
                           aisle = ?           AND
                           section = ?         AND
                           level = ?           AND
                           position =?',
                           v_part_number,
                           v_description,
                           v_serial_number,
                           v_expiration_date,
                           v_aisle,
                           v_section,
                           v_level,
                           v_position).first
  end
  def self.update_quantity?(v_part_number, v_description, v_serial_number, v_expiration_date, v_aisle, v_section, v_level, v_position)
    !ProductQuantity.where('part_number = ?     AND
                            description = ?     AND
                            serial_number = ?   AND
                            expiration_date = ? AND
                            aisle = ?           AND
                            section = ?         AND
                            level = ?           AND
                            position =?',
                            v_part_number,
                            v_description,
                            v_serial_number,
                            v_expiration_date,
                            v_aisle,
                            v_section,
                            v_level,
                            v_position).empty?
  end

  # def self.add_quantity(v_product_id, v_expiration_date, v_description, v_quantity)
  #   record = self.where('product_id = ? AND expiration_date = ?', v_product_id, v_expiration_date).first
    # Si el producto no existe -> nuevo registro
    # if record.nil?
    #   self.create(:product_id => v_product_id,
    #               :description => v_description,
    #               :quantity => v_quantity,
    #               :expiration_date => v_expiration_date)
    # Si el producto no existe -> actualizamos el registro
    # else
    #   record.update(:quantity => record.quantity + v_quantity)
    # end
  # end

  def self.subtract_quantity(v_product_id, v_expiration_date, v_quantity)
    record = ProductQuantity.where('product_id = ? AND expiration_date = ?', v_product_id, v_expiration_date).first
    record.update(:quantity=> record.quantity - v_quantity)
  end
end
