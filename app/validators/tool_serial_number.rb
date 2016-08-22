class ToolSerialNumber < ActiveModel::Validator
  def validate(record)
    if IncomingQuantity.where('tool_id = ?', record.tool_id).pluck(:serial_number).include?(record.serial_number)
      record.errors[:base] << 'El numero de serie esta en uso'
    end
  end
end

