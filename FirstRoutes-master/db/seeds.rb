# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(username: 'Harris')
User.create!(username: 'Robin')
User.create!(username: 'Tony')
User.create!(username: 'Abby')

Contact.create!(name: 'har', email: 'sjosijf', user_id: '1')
