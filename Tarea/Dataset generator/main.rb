require 'csv'
require 'faker'

SUPERMARKET_QUANQTITY = 3
CLIENT_QUANTITY = 20
PRODUCT_QUANTITY = 20
EVENT_QUANTITY = 160

supermarkets = []
clients = []
products = []
initial_stock = []
events = []

SUPERMARKET_QUANQTITY.times do |i|
  supermarkets << {
    id: i,
    name: Faker::Commerce.vendor,
    capacity: rand(2..(CLIENT_QUANTITY / 2).floor)
  }
end

CLIENT_QUANTITY.times do |i|
  clients << {
    id: i,
    name: Faker::Name.name,
    money: rand(100..50000)
  }
end

PRODUCT_QUANTITY.times do |i|
  products << {
    id: i,
    name: Faker::Commerce.product_name,
    price: rand(10..5000)
  }
end

supermarkets.each do |supermarket|
  products.each do |product|
    initial_stock << {
      supermarket_id: supermarket[:id],
      product_id: product[:id],
      quantity: rand(0..100)
    }
  end
end

possible_events = ['ARRIVAL', 'RESTOCK']
available_clients = clients.map(&:clone)
busy_clients = []

EVENT_QUANTITY.times do |i|
  selected_event = possible_events.sample
  if selected_event == 'ARRIVAL'
    selected_customer = available_clients.sample
    available_clients.delete(selected_customer)
    busy_clients << selected_customer
    selected_supermarket = supermarkets.sample
    events << "#{selected_event} #{selected_supermarket[:id]} #{selected_customer[:id]}"
    if not possible_events.include? 'CHECKOUT'
      possible_events << 'CHECKOUT'
    end
    if not possible_events.include? 'PICK'
      possible_events << 'PICK'
      possible_events << 'PICK'
    end
    if available_clients.length == 0
      possibles_events.delete('ARRIVAL')
    end
  elsif selected_event == 'CHECKOUT'
    selected_customer = busy_clients.sample
    busy_clients.delete(selected_customer)
    available_clients << selected_customer
    events << "#{selected_event} #{selected_customer[:id]}"
    if not possible_events.include? 'ARRIVAL'
      possible_events << 'ARRIVAL'
    end
    if busy_clients.length == 0
      possible_events.delete('CHECKOUT')
      possible_events.delete('PICK')
    end
  elsif selected_event == 'RESTOCK'
    selected_supermarket = supermarkets.sample
    selected_product = products.sample
    events << "#{selected_event} #{selected_supermarket[:id]} #{selected_product[:id]} #{rand(1..10)}"
  elsif selected_event == 'PICK'
    selected_customer = busy_clients.sample
    selected_product = products.sample
    events << "#{selected_event} #{selected_customer[:id]} #{selected_product[:id]} #{rand(1..5)}"
  end
end

CSV.open('./data/supermarkets.csv', "w") do |csv|
  csv << ['id', 'name', 'capacity']
  supermarkets.each do |supermarket|
    csv << [supermarket[:id], supermarket[:name], supermarket[:capacity]]
  end
end

CSV.open('./data/clients.csv', "w") do |csv|
  csv << ['id', 'name', 'money']
  clients.each do |client|
    csv << [client[:id], client[:name], client[:money]]
  end
end

CSV.open('./data/products.csv', "w") do |csv|
  csv << ['id', 'name', 'price']
  products.each do |product|
    csv << [product[:id], product[:name], product[:price]]
  end
end

CSV.open('./data/stock.csv', "w") do |csv|
  csv << ['supermarket', 'product', 'quantity']
  initial_stock.each do |stock|
    csv << [stock[:supermarket_id], stock[:product_id], stock[:quantity]]
  end
end

File.open('./data/events.txt', 'w') do |file|
  file.puts events
end
