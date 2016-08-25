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

User.create(:name => 'Armando Guerra')
User.create(:name => 'Federico De Los Palotes')
User.create(:name => 'Juan Tenorio')


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

@aircraft = Aircraft.create(:manufacturer => 'EUROCOPTER', :trade_name => 'EC 145')
@system = @aircraft.systems.create(:title => 'TAIL ROTOR DRIVE', :chapter_number => '65')



