module ApplicationHelper
  def add_in_class1(class_name)
    if class_name == 'product_units'           ||
       class_name == 'products'                ||
       class_name == 'suppliers'               ||
       class_name == 'incoming_movement_types' ||
       class_name == 'outgoing_movement_types' ||
       class_name == 'receivers'               ||
       class_name == 'incoming_movements'      ||
       class_name == 'outgoing_movements'
      'in'
    end
  end
  def add_in_class2(class_name)
    if class_name == 'aircrafts'
      'in'
    end
  end
  def add_in_class3(class_name)
    if class_name == 'fleets'
      'in'
    end
  end
end
