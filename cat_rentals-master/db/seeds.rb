# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
names = %w(harris konrad slipper fuzzies dante frenchy catherine professor_x
          senator_fuzzball napolean einstein)
colors = ['black', 'brown', 'orange', 'grey', 'white', 'orange with black strips' ]
sex = ['m', 'f']

User.create!(:user_name => "warrior1", :password_digest => BCrypt::Password.create('warrior1') )
User.create!(:user_name => "warrior2", :password_digest => BCrypt::Password.create('warrior2') )
User.create!(:user_name => "warrior3", :password_digest => BCrypt::Password.create('warrior3') )
User.create!(:user_name => "warrior4", :password_digest => BCrypt::Password.create('warrior4') )
User.create!(:user_name => "warrior5", :password_digest => BCrypt::Password.create('warrior5') )
User.create!(:user_name => "warrior6", :password_digest => BCrypt::Password.create('warrior6') )
User.create!(:user_name => "warrior7", :password_digest => BCrypt::Password.create('warrior7') )
User.create!(:user_name => "warrior8", :password_digest => BCrypt::Password.create('warrior8') )

User.all.count.times do |i|
  cat = {color: colors.sample, birth_date: rand(1..5).year.ago,
        name: names.sample, sex: sex.sample}
  User.all[i].cats.create!(cat)
end
Cat.first.update(description: "this is such a nice cat that no longer has rabies")

User.all.count.times do |i|
  random_date = (1.year.ago)
  start_date = random_date - (i + 1).months
  CatRentalRequest.create!(start_date: start_date, end_date: random_date, cat_id: i + 1, status: 'APPROVED', user_id: 5)
end

User.all.count.times do |i|
  random_date = (0.year.ago)
  start_date = random_date - (i + 1).months
  CatRentalRequest.create!(start_date: start_date, end_date: random_date, cat_id: User.all.count - i, user_id: 5)
end
