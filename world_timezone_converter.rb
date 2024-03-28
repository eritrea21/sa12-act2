require 'httparty'
require 'json'

def fetch_timezone_data(area, location)
  url = "http://worldtimeapi.org/api/timezone/#{area}/#{location}"
  response = HTTParty.get(url)

  if response.success?
    return JSON.parse(response.body)
  else
    puts "Error: #{response.code}, #{response.message}"
    return {}
  end
end

def format_output(area, location, current_date_time)
  puts "The current time in #{area} / #{location} is #{current_date_time}"
end

# Specify the area and location for the timezone you want to fetch
area = 'Europe'
location = 'London'

timezone_data = fetch_timezone_data(area, location)

if timezone_data.key?('datetime')
  current_date_time = timezone_data['datetime'].split('T').join(' ').split('+').first
  format_output(area, location, current_date_time)
else
  puts "Unable to retrieve current time for the specified timezone."
end
