# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Created banks"
Bank.create!(name: "FirstBank", entity_id: 111)
Bank.create!(name: "SecondBank", entity_id: 222)
puts "Created banks"
Bank.first.accounts.create!({ "amount": 30000, "owner": "Jim"})
Bank.first.accounts.create!({ "amount": 0, "owner": "Joss"})
Bank.last.accounts.create!({ "amount": 0, "owner": "Emma"})
Bank.last.accounts.create!({ "amount": 0, "owner": "Jusep"})

puts "Accounts"
Account.all.each do |account|
  puts "bank: #{account.bank.name}"
  puts "-------------------"
  puts "owner: #{account.owner}"
  puts "isbn: #{account.isbn}"
  puts "money: #{account.amount}"
  puts "-------------------"
end

jim_account = Account.find_by(owner: "Jim")
emma_account = Account.find_by(owner: "Emma")

AgentTransactor.process(jim_account.id, emma_account.id, 20000)