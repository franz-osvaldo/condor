class Location < ActiveModel::Validator
  def validate(record)
    if different_product?(record)
        record.errors[:base] << 'Existe un producto diferente en esta ubicación'
    end
  end
  private
  def different_product?(record)
    unless IncomingDetail.where('aisle = ? AND section = ? AND level = ? AND position = ?', record.aisle, record.section, record.level, record.position).empty?
      return IncomingDetail.where('aisle = ? AND  section = ? AND level = ? AND position = ?', record.aisle,  record.section, record.level, record.position).first.product.part_number != record.product.part_number ||
             IncomingDetail.where('aisle = ? AND section = ? AND level = ? AND position = ?',record.aisle, record.section, record.level, record.position).first.product.description != record.product.description
    end
    false
  end
end


