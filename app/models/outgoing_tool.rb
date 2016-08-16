class OutgoingTool < ApplicationRecord
  belongs_to :outgoing_tool_type
  has_many :outgoing_quantities
  has_many :tools, through: :outgoing_quantities
  before_save :set_number_folio

  private
  # Obtener el ultimo numero de folio y sumarle 1
  def self.get_number_folio
    numero_folio = OutgoingTool.all.last.folio             # 'SALIDA000023'
    solo_numero = numero_folio.scan(/\d/).join('')             # '000023'
    solo_cadena = numero_folio.scan(/[a-zA-Z]/).join('')       # 'SALIDA'
    nuevo_numero = (solo_numero.to_i + 1).to_s                 # '24'
    solo_cadena + nuevo_numero.rjust(solo_numero.length, '0')  # 'SALIDA000024'
  end

  def set_number_folio
    if OutgoingTool.all.length == 0
      self.folio = 'SALIDA000001'
    else
      self.folio = OutgoingTool.get_number_folio
    end
  end
end

