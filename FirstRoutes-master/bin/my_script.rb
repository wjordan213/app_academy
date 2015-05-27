# bin/my_script.rb

require 'addressable/uri'
require 'rest-client'


# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users.html',
#
#   query: "bubble=tea"
#
# ).to_s


# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users.json',
#   # path: '/users/5.json',
#   query_values: {
#     'dogs[color]' => 'black',
#     'dogs[legs]' => 4,
#     'some_category[inner_inner_hash][key]' => 'value',
#     'something_else' => 'aaahhhhh'
#   }
# ).to_s
#
url2 = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/1/contacts.json',
).to_s
#
# puts RestClient.get(url)
# puts RestClient.post(url2, {})


url3 = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/contacts/1.json',
).to_s



def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s

  puts RestClient.post(
    url,
    { user: { name: "Gizmo", email: "gizmo@gizmo.gizmo" } }
  )
end



puts RestClient.get(url2)

puts RestClient.patch(url3, {
   contact: {
     name: 'harris',
     email: 'wwehfoije',
     user_id: 13
   }
 })

# puts RestClient.delete(url3)

# begin
#   create_user
# rescue RestClient::Exception
# end
