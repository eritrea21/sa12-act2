require 'httparty'
require 'json'

def fetch_repository_data(username)
  url = "https://api.github.com/users/#{username}/repos"
  response = HTTParty.get(url)

  if response.success?
    repositories = JSON.parse(response.body)
    return repositories
  else
    puts "Error: #{response.code}, #{response.message}"
    return []
  end
end

def analyze_repositories(repositories)
  max_star_count = 0
  repository_with_max_stars = nil

  repositories.each do |repo|
    name = repo['name']
    star_count = repo['stargazers_count']
    fork_count = repo['forks_count']

    puts "Repository: #{name}, Stars: #{star_count}, Forks: #{fork_count}"

    if star_count > max_star_count
      max_star_count = star_count
      repository_with_max_stars = name
    end
  end

  puts "Repository with the highest star count: #{repository_with_max_stars} (#{max_star_count} stars)" if repository_with_max_stars
end

# Replace 'your_username' with the GitHub username you want to fetch repository data for
username = 'eritrea21'
repositories = fetch_repository_data(username)

if repositories.any?
  puts "Repositories for #{username}:"
  analyze_repositories(repositories)
else
  puts "No repositories found for #{username}."
end
