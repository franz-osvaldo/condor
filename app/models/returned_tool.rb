class ReturnedTool < ApplicationRecord
  belongs_to :user
  has_many :returned_quantities
  has_many :tool_quantities, through: :returned_quantities
  before_save :set_number_folio
  private

  # Obtener el ultimo numero de folio y sumarle 1
  def self.get_number_folio
    numero_folio = ReturnedTool.all.last.folio                 # 'DEVOLUCIÓN000023'
    solo_numero = numero_folio.scan(/\d/).join('')             # '000023'
    solo_cadena = numero_folio.scan(/[a-zA-Z]/).join('')       # 'DEVOLUCIÓN'
    nuevo_numero = (solo_numero.to_i + 1).to_s                 # '24'
    solo_cadena + nuevo_numero.rjust(solo_numero.length, '0')  # 'DEVOLUCIÓN000024'
  end
  # Obtenemos el numero de folio, el tipo de movimiento y el proveedor del primer movimiento de ingreso a almacén
  def set_number_folio
    if ReturnedTool.all.length == 0
      self.folio = 'DEVOLUCION000001'
    else
      self.folio = ReturnedTool.get_number_folio
    end
  end
end

