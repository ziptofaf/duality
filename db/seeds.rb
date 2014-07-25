# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

processors = Processor.create([{ name: 'dogecoin', usable: 1}, { name: 'bitcoin', usable: 1},
{ name: 'paypal', usable: 1}])

product_processors = ProductProcessor.create([{name: 'vpn', usable: 1},{name: 'placeholder', usable: 0}])

pool = ServerPool.create([{name: 'basic'}, {name: 'medium'}, {name: 'advanced'}, {name: 'extreme'}])
