class Fleet < ApplicationRecord
  belongs_to :aircraft
  has_many :flights
  has_many :time_details
  has_many :parts, through: :time_details
  has_many :alert_tbos
  has_many :tbos, through: :alert_tbos

  after_create :set_time_details
  def total_flight_hours
    self.flights.sum(:flight_time)
  end

  def my_parts
    Part.joins(component: [{system: [{aircraft: :fleets}]}]).where('fleets.id' => self.id)
  end

  def set_time_details
    self.my_parts.each do |part|
      TimeDetail.create(part_id: part.id,
                        fleet_id: self.id,
                        fhsn: 0,
                        dsn: 0,
                        fhso: 0,
                        dso: 0,
                        overhaul_state: 'new',
                        overhaul_date: DateTime.now)
    end
  end

  def find_out_tbos
    self.time_details.each do |time_detail|
      time_detail.part.tbos.each do |tbo|
        if (tbo.condition.name == 'No requerido' || tbo.condition.name == 'TSO') && tbo.unit.name == 'Flight hours'
          if (tbo.time_limit - tbo.alert_before) <= tbo.part.time_details.first.fhso &&
             (tbo.time_limit + tbo.over_the_time_limit) >= tbo.part.time_details.first.fhso
            # si el tbo no esta registrado
            if AlertTbo.where('tbo_id = ? AND fleet_id = ?', tbo.id, self.id).empty?
              AlertTbo.create(fleet_id: self.id, tbo_id: tbo.id, state: 'pending')
            else
              # si el tbo existe pero su estado es accomplished
              if AlertTbo.where('tbo_id = ? AND fleet_id = ?', tbo.id, self.id).order('id DESC').first.state == 'accomplished'
                AlertTbo.create(fleet_id: self.id, tbo_id: tbo.id, state: 'pending')
              end
            end
          end
        end
        if tbo.condition.name == 'TSN' && tbo.unit.name == 'Flight hours'
          if (tbo.time_limit - tbo.alert_before) <= tbo.part.time_details.first.fhsn &&
              (tbo.time_limit + tbo.over_the_time_limit) >= tbo.part.time_details.first.fhsn
            # si el tbo no esta registrado
            if AlertTbo.where('tbo_id = ? AND fleet_id = ?', tbo.id, self.id).empty?
              AlertTbo.create(fleet_id: self.id, tbo_id: tbo.id, state: 'pending')
            else
              # si el tbo existe pero su estado es accomplished
              if AlertTbo.where('tbo_id = ? AND fleet_id = ?', tbo.id, self.id).order('id DESC').first.state == 'accomplished'
                AlertTbo.create(fleet_id: self.id, tbo_id: tbo.id, state: 'pending')
              end
            end
          end
        end
        if (tbo.condition.name == 'No requerido' || tbo.condition.name == 'TSO') && tbo.unit.name == 'Years'
          if (tbo.time_limit_in_days - tbo.alert_before_in_days) <= tbo.part.time_details.first.dso &&
              (tbo.time_limit_in_days + tbo.over_the_time_limit_in_days) >= tbo.part.time_details.first.dso
            # si el tbo no esta registrado
            if AlertTbo.where('tbo_id = ? AND fleet_id = ?', tbo.id, self.id).empty?
              AlertTbo.create(fleet_id: self.id, tbo_id: tbo.id, state: 'pending')
            else
              # si el tbo existe pero su estado es accomplished
              if AlertTbo.where('tbo_id = ? AND fleet_id = ?', tbo.id, self.id).order('id DESC').first.state == 'accomplished'
                AlertTbo.create(fleet_id: self.id, tbo_id: tbo.id, state: 'pending')
              end
            end
          end
        end
        if tbo.condition.name == 'TSN' && tbo.unit.name == 'Years'
          if (tbo.time_limit - tbo.alert_before) <= tbo.part.time_details.first.dsn &&
              (tbo.time_limit + tbo.over_the_time_limit) >= tbo.part.time_details.first.dsn
            # si el tbo no esta registrado
            if AlertTbo.where('tbo_id = ? AND fleet_id = ?', tbo.id, self.id).empty?
              AlertTbo.create(fleet_id: self.id, tbo_id: tbo.id, state: 'pending')
            else
              # si el tbo existe pero su estado es accomplished
              if AlertTbo.where('tbo_id = ? AND fleet_id = ?', tbo.id, self.id).order('id DESC').first.state == 'accomplished'
                AlertTbo.create(fleet_id: self.id, tbo_id: tbo.id, state: 'pending')
              end
            end
          end
        end
      end
    end

  end
end
