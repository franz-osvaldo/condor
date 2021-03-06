# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Unit.create(:name => 'Flight hours')
Unit.create(:name => 'Years')
Unit.create(:name => 'Months')
Unit.create(:name => 'Days')

Condition.create(:name => 'TSN')
Condition.create(:name => 'TSO')
Condition.create(:name => 'No requerido')

FlightCrew.create(:name => 'Franz Beltran')
FlightCrew.create(:name => 'Abel Lopez')
FlightCrew.create(:name => 'Fabian Pardo')
FlightCrew.create(:name => 'Mauricio Canelas')
FlightCrew.create(:name => 'Juan Perez')

Inspection.create(:name => 'Nuevo')
Inspection.create(:name => 'Supplementary Check 50 Fh')
Inspection.create(:name => 'Supplementary Check 100 Fh')
Inspection.create(:name => 'Intermediate Inspection')
Inspection.create(:name => '12-Months Inspection')
Inspection.create(:name => 'Periodical Inspection')
Inspection.create(:name => 'Supplementary Inspections according to Flight Hour and / or Calendar Time')


@unidad1 = ProductUnit.create(:name => 'Litros')
@unidad2 = ProductUnit.create(:name => 'Piezas')
@unidad3 = ProductUnit.create(:name => 'Botellas')
@unidad4 = ProductUnit.create(:name => 'Metros')

Product.create(:part_number => '320912BL-TUBE20ML', :description => 'Safety Lacquer', :specification => 'Sin especificación', :procurement_lead_time => 90,:maximum => 5,:minimum => 1,:optimum =>3, :product_unit_id => @unidad3.id)
Product.create(:part_number => 'MIL-PRF-680', :description => 'Dry Cleaning Solvent', :specification => 'Sin especificación', :procurement_lead_time => 270,:maximum => 3,:minimum => 1,:optimum =>2, :product_unit_id => @unidad3.id)

Supplier.create(:supplier => 'Eurocopter')
Supplier.create(:supplier => 'American Parts')
Supplier.create(:supplier => 'Mil Parts')

Receiver.create(:receiver => 'Juan Perez')
Receiver.create(:receiver => 'Gian Luca')
Receiver.create(:receiver => 'Cat Stevens')

occupation1 = Occupation.create(name: 'Admin')
occupation2 = Occupation.create(name: 'Mecanico')

User.create(:name => 'Administrador', email: 'admin@gmail.com', password: '12345678', password_confirmation: '12345678', occupation_id: occupation1.id)
User.create(:name => 'Franz Beltran', email: 'franzbeltran79@gmail.com', password: '12345678', password_confirmation: '12345678', occupation_id: occupation2.id, receiver: true)




IncomingMovementType.create(:movement_type => 'Compra')
IncomingMovementType.create(:movement_type => 'Donación')
IncomingMovementType.create(:movement_type => 'Traspaso')

OutgoingMovementType.create(:movement_type => 'Mantenimiento')
OutgoingMovementType.create(:movement_type => 'Devolución al proveedor')


IncomingToolType.create(:movement_type => 'Compra')
IncomingToolType.create(:movement_type => 'Donación')
IncomingToolType.create(:movement_type => 'Traspaso')

OutgoingToolType.create(:movement_type => 'Mantenimiento')
OutgoingToolType.create(:movement_type => 'Devolución al proveedor')



Tool.create(:part_number => 'ABC123', :description => 'Angle Gauge', :specification => 'Sin especificación')
Tool.create(:part_number => 'XYZ123', :description => '90° Angle Block', :specification => 'Sin especificación')
Tool.create(:part_number => '105-31702 W24', :description => 'Check Device', :specification => 'Sin especificación')
Tool.create(:part_number => '105-31803 W2', :description => 'Measuring Device', :specification => 'Sin especificación')

@aircraft1 = Aircraft.create(:manufacturer => 'EUROCOPTER', :trade_name => 'EC 145')
@system1 = @aircraft1.systems.create(:title => 'TAIL ROTOR DRIVE', :chapter_number => '65')

@component1 = @system1.components.create(:name => 'Componente')

@parts1 = @component1.parts.create([{description: 'parte 1', part_number: 'ABC1'},
                                   {description: 'parte 2', part_number: 'ABC2'},
                                   {description: 'parte 3', part_number: 'ABC3'},
                                   {description: 'parte 4', part_number: 'ABC4'},
                                   {description: 'parte 5', part_number: 'ABC5'},
                                   {description: 'parte 6', part_number: 'ABC6'},
                                   {description: 'parte 7', part_number: 'ABC7'},
                                   {description: 'parte 8', part_number: 'ABC8'}])


@aircraft2 = Aircraft.create(:manufacturer => 'EUROCOPTER', :trade_name => 'ASB 310')
@system2 = @aircraft2.systems.create(:title => 'GENERAL', :chapter_number => '1')

@component2 = @system2.components.create(:name => 'Componente')

@parts2 = @component2.parts.create([{description: 'parte 1', part_number: 'XYZ1'},
                                    {description: 'parte 2', part_number: 'XYZ2'},
                                    ])


# TAREAS

Task.create(name: 'Tarea 1', task_number: '65-32-00, 6-1', tool_ids: [1], product_ids: [1], system_id: 1)
Task.create(name: 'Tarea 2', task_number: '65-22-00, 6-6', tool_ids: [1], product_ids: [1], system_id: 1)






Tbo.create(part_id: 1, condition_id: 3, unit_id: 1, time_limit: 800, over_the_time_limit: 100, alert_before: 100)
Tbo.create(part_id: 2, condition_id: 3, unit_id: 2, time_limit: 5, over_the_time_limit: 0.5, alert_before: 0.5)
Tbo.create(part_id: 3, condition_id: 1, unit_id: 2, time_limit: 5, over_the_time_limit: 0.5, alert_before: 0.5)
Tbo.create(part_id: 3, condition_id: 2, unit_id: 2, time_limit: 5, over_the_time_limit: 0.5, alert_before: 0.5)
# Tbo.create(part_id: 4, condition_id: 3, unit_id: 1, time_limit: 30, over_the_time_limit: 6, alert_before: 6)
# Tbo.create(part_id: 5, condition_id: 3, unit_id: 1, time_limit: 8, over_the_time_limit: 2, alert_before: 2)
# Tbo.create(part_id: 6, condition_id: 1, unit_id: 2, time_limit: 2, over_the_time_limit: 1, alert_before: 0.5)


# Fluid.create(part_id: 1, condition_id: 1, unit_id: 1, time_limit: 4, over_the_time_limit: 2, alert_before: 2)
# Fluid.create(part_id: 1, condition_id: 3, unit_id: 1, time_limit: 10, over_the_time_limit: 2, alert_before: 2)
# Fluid.create(part_id: 2, condition_id: 1, unit_id: 1, time_limit: 20, over_the_time_limit: 4, alert_before: 4)
# Fluid.create(part_id: 2, condition_id: 2, unit_id: 1, time_limit: 20, over_the_time_limit: 4, alert_before: 4)
# Fluid.create(part_id: 2, condition_id: 3, unit_id: 1, time_limit: 30, over_the_time_limit: 6, alert_before: 6)
# Fluid.create(part_id: 5, condition_id: 1, unit_id: 1, time_limit: 30, over_the_time_limit: 4, alert_before: 4, tbo_id: 5)

LifeTimeLimit.create(part_id: 8, unit_id: 1, life_limit: 1200,  alert_before: 100)

# Fluid.create(part_id: 1, condition_id: 1, unit_id: 1, time_limit: 100, over_the_time_limit: 20, alert_before: 20)
# Fluid.create(part_id: 1, condition_id: 2, unit_id: 1, time_limit: 100, over_the_time_limit: 20, alert_before: 20)
# Fluid.create(part_id: 1, condition_id: 3, unit_id: 1, time_limit: 80, over_the_time_limit: 10, alert_before: 10)
# Fluid.create(part_id: 1, condition_id: 1, unit_id: 3, time_limit: 12, over_the_time_limit: 3, alert_before: 3)
# Fluid.create(part_id: 1, condition_id: 2, unit_id: 3, time_limit: 12, over_the_time_limit: 3, alert_before: 3)
# Fluid.create(part_id: 1, condition_id: 3, unit_id: 3, time_limit: 10, over_the_time_limit: 2, alert_before: 2)

# **********************************************************************************************************************
# TSN - Flight hours
Fluid.create(part_id: 1, condition_id: 1, unit_id: 1, time_limit: 400, over_the_time_limit: 100, alert_before: 100)
# TSO - Flight hours
Fluid.create(part_id: 1, condition_id: 2, unit_id: 1, time_limit: 400, over_the_time_limit: 100, alert_before: 100)
# No requerido - Flight hours
# Fluid.create(part_id: 1, condition_id: 3, unit_id: 1, time_limit: 300, over_the_time_limit: 100, alert_before: 100)
# **********************************************************************************************************************
# TSN - Months
# Fluid.create(part_id: 1, condition_id: 1, unit_id: 3, time_limit: 12, over_the_time_limit: 3, alert_before: 3)
# TSO - Months
# Fluid.create(part_id: 1, condition_id: 2, unit_id: 3, time_limit: 12, over_the_time_limit: 3, alert_before: 3)
# No requerido - Months
# Fluid.create(part_id: 1, condition_id: 3, unit_id: 3, time_limit: 10, over_the_time_limit: 2, alert_before: 2)
# **********************************************************************************************************************

Fleet.create(aircraft_id: 1, name: 'Condor', aircraft_registration: 'FAB-001')

# 1000.times{
#   Product.create(procurement_lead_time: Faker::Number.between(1, 10) ,part_number: Faker::Code.isbn,description: Faker::Name.last_name ,specification: Faker::Lorem.sentence(3),maximum: Faker::Number.between(1, 10), minimum: Faker::Number.between(1, 10), product_unit_id: 3)
# }
