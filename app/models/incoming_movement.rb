class IncomingMovement < ApplicationRecord
  belongs_to :incoming_movement_type
  belongs_to :supplier
  has_many :incoming_details
  has_many :products, through: :incoming_details

  before_save :set_number_folio

  private

  # Obtener el ultimo numero de folio y sumarle 1
  def self.get_number_folio
    numero_folio = IncomingMovement.all.last.folio             # 'SALIDA000023'
    solo_numero = numero_folio.scan(/\d/).join('')             # '000023'
    solo_cadena = numero_folio.scan(/[a-zA-Z]/).join('')       # 'SALIDA'
    nuevo_numero = (solo_numero.to_i + 1).to_s                 # '24'
    solo_cadena + nuevo_numero.rjust(solo_numero.length, '0')  # 'SALIDA000024'
  end
  # Obtenemos el numero de folio, el tipo de movimiento y el proveedor del primer movimiento de ingreso a almacén
  def set_number_folio
    if IncomingMovement.all.length == 0
      self.folio = 'ENTRADA000001'
    else
      self.folio = IncomingMovement.get_number_folio
    end
  end
end
