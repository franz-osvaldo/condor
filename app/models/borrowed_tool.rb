class BorrowedTool < ApplicationRecord
  belongs_to :user
  has_many :borrowed_quantities
  has_many :tool_quantities, through: :borrowed_quantities
  before_save :set_number_folio, :set_state



  private
  # Obtener el ultimo numero de folio y sumarle 1
  def self.get_number_folio
    numero_folio = BorrowedTool.all.last.folio                 # 'RESGUARDO000023'
    solo_numero = numero_folio.scan(/\d/).join('')             # '000023'
    solo_cadena = numero_folio.scan(/[a-zA-Z]/).join('')       # 'RESGUARDO'
    nuevo_numero = (solo_numero.to_i + 1).to_s                 # '24'
    solo_cadena + nuevo_numero.rjust(solo_numero.length, '0')  # 'RESGUARDO000024'
  end

  def set_number_folio
    if BorrowedTool.all.length == 0
      self.folio = 'RESGUARDO000001'
    else
      self.folio = BorrowedTool.get_number_folio
    end
  end

  def set_state
    self.state = 'Resguardo'
  end
end
