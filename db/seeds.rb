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
Inspection.create(:name => 'Supplementary Check 50 Fh')
Inspection.create(:name => 'Supplementary Check 100 Fh')
Inspection.create(:name => 'Intermediate Inspection')
Inspection.create(:name => '12-Months Inspection')
Inspection.create(:name => 'Periodical Inspection')
Inspection.create(:name => 'Supplementary Inspections according to Flight Hour and / or Calendar Time')
