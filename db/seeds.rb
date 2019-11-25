# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'cpf_gen'
require 'cnpj_gen'

# Create DEV user
dev = User::create name: 'DEV', password: 'dev', role: 0
User::create name: 'ADMINISTRADOR', password: 'admin', role: 1
User::create name: 'SUPERVISOR', password: 'super', role: 2
User::create name: 'OPERADOR', password: 'op', role: 3
User::create name: 'SINDICO', password: 'sin', role: 4
User::create name: 'CONDOMINO', password: 'con', role: 5

puts 'Generating data...'

# Create some DATA
5.times do
  # Groups:
  f = Facility::create name: Faker::Company.unique.name, created_by_id: dev.id 
  puts f
  c = Company::create name: Faker::Company.unique.name, cnpj: CNPJ::factory, created_by_id: dev.id
  puts c
  
  # Entities:
  5.times do
    r = Resident::create name: Faker::Name.unique.name, facility: f, number: rand(100), created_by_id: dev.id
    puts r
    e = Employee::create name: Faker::Name.unique.name, cpf: CPF::factory, company: c, plate: 'AAA 0B00', created_by_id: dev.id
    puts e
    v = Visitor::create name: Faker::Name.unique.name, cpf: CPF::factory, plate: 'BBB 1A11', created_by_id: dev.id
    puts v
  
    # Appointments:
    5.times do
      professional = Faker::Boolean.boolean
      visitor = professional ? e : v
      type = visitor.class.name

      puts Appointment::create description: Faker::Verb.base.capitalize + ?\s + Faker::Construction.material.downcase, date: Faker::Time.forward, professional: professional,
        host_id: r.id,
        visitor_type: type,
        visitor_id: visitor.id,
        created_by_id: dev.id
    end
  end
end

puts 'Done! お待たせ致しました！'
