require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.name  { Faker::Name.name }
Sham.email { Faker::Internet.email }
Sham.title { Faker::Lorem.sentence }
#Sham.body  { Faker::Lorem.paragraph }

User.blueprint do
  email
  password { 'secret' }
  password_confirmation { 'secret'}
end

User.blueprint(:foo) do
  email { 'foo@example.com'}
end

User.blueprint(:bar) do
  email { 'bar@example.com'}
end
