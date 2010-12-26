require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.name  { Faker::Name.name }
Sham.email { Faker::Internet.email }
Sham.zipcode { Faker::Address.zip_code  }
Sham.title { Faker::Lorem.sentence }
#Sham.body  { Faker::Lorem.paragraph }

User.blueprint do
  email
  zipcode { '03585'}
  password { 'secret' }
  password_confirmation { 'secret'}
  lat { 100.1 }
  lng { 200.2 } #avoid calling MultiGeocoder
end

User.blueprint(:example) do
  email { 'example@example.com'}
end

User.blueprint(:foo) do
  email { 'foo@example.com'}
end

User.blueprint(:bar) do
  email { 'bar@example.com'}
end
