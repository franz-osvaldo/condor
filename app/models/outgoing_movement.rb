class OutgoingMovement < ApplicationRecord
  belongs_to :outgoing_movement_type
  belongs_to :receiver
  has_many :outgoing_details
  has_many :products, through: :outgoing_details
  before_save :set_number_folio

  private
  # Obtener el ultimo numero de folio y sumarle 1
  def self.get_number_folio
    numero_folio = OutgoingMovement.all.last.folio             # 'SALIDA000023'
    solo_numero = numero_folio.scan(/\d/).join('')             # '000023'
    solo_cadena = numero_folio.scan(/[a-zA-Z]/).join('')       # 'SALIDA'
    nuevo_numero = (solo_numero.to_i + 1).to_s                 # '24'
    solo_cadena + nuevo_numero.rjust(solo_numero.length, '0')  # 'SALIDA000024'
  end

  def set_number_folio
    if OutgoingMovement.all.length == 0
      self.folio = 'SALIDA000001'
    else
      self.folio = OutgoingMovement.get_number_folio
    end
  end
end

