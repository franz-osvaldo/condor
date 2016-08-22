class ToolLocation < ActiveModel::Validator
  def validate(record)
    if different_product?(record)
      record.errors[:base] << 'Existe una herramienta diferente en esta ubicación'
    end
  end
  private
  def different_product?(record)
    unless IncomingQuantity.where('aisle = ? AND section = ? AND level = ? AND position = ?', record.aisle, record.section, record.level, record.position).empty?
      return IncomingQuantity.where('aisle = ? AND  section = ? AND level = ? AND position = ?', record.aisle,  record.section, record.level, record.position).first.tool.part_number != record.tool.part_number ||
          IncomingQuantity.where('aisle = ? AND section = ? AND level = ? AND position = ?',record.aisle, record.section, record.level, record.position).first.tool.description != record.tool.description
    end
    false
  end
end

