class Fleet < ApplicationRecord
  belongs_to :aircraft
  has_many :flights
  has_many :time_details
  has_many :parts, through: :time_details
  has_many :alert_tbos
  has_many :tbos, through: :alert_tbos

  has_many :alert_life_limits
  has_many :life_time_limits, through: :alert_life_limits

  has_many :alert_fluids
  has_many :fluids, through: :alert_fluids

  after_create :set_time_details

  def find_out_alert_life_limits
    self.alert_life_limits.where('state = ?', 'pending')
  end

  def find_out_alert_fluids
    self.alert_fluids.where('state = ?', 'pending')
  end

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
                        fhso: -876000,
                        dso: -36500,
                        overhaul_state: 'new',
                        overhaul_date: DateTime.now - 100.years,
                        date_since_new: DateTime.now)
    end
  end

  def find_out_tbos
    self.time_details.each do |time_detail|
      time_detail.part.tbos.each do |tbo|
        if tbo.condition.name == 'No requerido'  && tbo.unit.name == 'Flight hours'
          if tbo.part.time_details.first.date_since_new > tbo.part.time_details.first.overhaul_date
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
          else
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
        end

        if tbo.condition.name == 'No requerido'  && tbo.unit.name == 'Years'
          if tbo.part.time_details.first.date_since_new > tbo.part.time_details.first.overhaul_date
            if tbo.part.time_details.first.dsn  >= ((tbo.part.time_details.first.date_since_new + tbo.time_limit.to_i.years - (tbo.alert_before*365).to_i.days)- tbo.part.time_details.first.date_since_new)/(60*60*24) &&
                tbo.part.time_details.first.dsn <= ((tbo.part.time_details.first.date_since_new + tbo.time_limit.to_i.years + (tbo.over_the_time_limit*365).to_i.days)- tbo.part.time_details.first.date_since_new)/(60*60*24)
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
          else
            if tbo.part.time_details.first.dso  >= ((tbo.part.time_details.first.overhaul_date + tbo.time_limit.to_i.years - (tbo.alert_before*365).to_i.days)- tbo.part.time_details.first.overhaul_date)/(60*60*24) &&
                tbo.part.time_details.first.dso <= ((tbo.part.time_details.first.overhaul_date + tbo.time_limit.to_i.years + (tbo.over_the_time_limit*365).to_i.days)- tbo.part.time_details.first.overhaul_date)/(60*60*24)
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
        if tbo.condition.name == 'TSN' && tbo.unit.name == 'Years'
          if tbo.part.time_details.first.date_since_new > tbo.part.time_details.first.overhaul_date
            if tbo.part.time_details.first.dsn  >= ((tbo.part.time_details.first.date_since_new + tbo.time_limit.to_i.years - (tbo.alert_before*365).to_i.days)- tbo.part.time_details.first.date_since_new)/(60*60*24) &&
                tbo.part.time_details.first.dsn <= ((tbo.part.time_details.first.date_since_new + tbo.time_limit.to_i.years + (tbo.over_the_time_limit*365).to_i.days)- tbo.part.time_details.first.date_since_new)/(60*60*24)
              # si el tbo no esta registrado
              if AlertTbo.where('tbo_id = ? AND fleet_id = ? AND created_at > ?', tbo.id, self.id, self.time_details.first.date_since_new).empty?
                AlertTbo.create(fleet_id: self.id, tbo_id: tbo.id, state: 'pending')
              end
            end
          end
        end

        if tbo.condition.name == 'TSO' && tbo.unit.name == 'Years'
          if tbo.part.time_details.first.date_since_new < tbo.part.time_details.first.overhaul_date
            if tbo.part.time_details.first.dso  >= ((tbo.part.time_details.first.overhaul_date + tbo.time_limit.to_i.years - (tbo.alert_before*365).to_i.days)- tbo.part.time_details.first.overhaul_date)/(60*60*24) &&
                tbo.part.time_details.first.dso <= ((tbo.part.time_details.first.overhaul_date + tbo.time_limit.to_i.years + (tbo.over_the_time_limit*365).to_i.days)- tbo.part.time_details.first.overhaul_date)/(60*60*24)
              # si el tbo no esta registrado
              if AlertTbo.where('tbo_id = ? AND fleet_id = ? AND created_at > ?', tbo.id, self.id, self.time_details.first.overhaul_date).empty?
                AlertTbo.create(fleet_id: self.id, tbo_id: tbo.id, state: 'pending')
              end
            end
          end
        end

      end
    end

  end
end
