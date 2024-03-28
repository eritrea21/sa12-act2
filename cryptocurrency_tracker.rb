require 'httparty'
require 'json'

def fetch_cryptocurrency_data
  url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd'
  response = HTTParty.get(url)

  if response.success?
    return JSON.parse(response.body)
  else
    puts "Error: #{response.code}, #{response.message}"
    return []
  end
end

def sort_by_market_capitalization(cryptocurrencies)
  cryptocurrencies.sort_by { |crypto| -crypto['market_cap'] }
end

def display_top_5_cryptocurrencies(cryptocurrencies)
  puts "Top 5 Cryptocurrencies by Market Capitalization:"
  puts "%-5s %-25s %-15s %-15s" % ["Rank", "Name", "Price (USD)", "Market Cap (USD)"]

  top_5 = cryptocurrencies.take(5)
  top_5.each_with_index do |crypto, index|
    name = crypto['name']
    price = crypto['current_price']
    market_cap = crypto['market_cap']

    puts "%-5d %-25s %-15.2f %-15.2f" % [index + 1, name, price, market_cap]
  end
end

cryptocurrencies = fetch_cryptocurrency_data

if cryptocurrencies.any?
  sorted_cryptocurrencies = sort_by_market_capitalization(cryptocurrencies)
  display_top_5_cryptocurrencies(sorted_cryptocurrencies)
else
  puts "No cryptocurrency data available."
end
