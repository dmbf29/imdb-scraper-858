require 'yaml'
require_relative 'scraper'
# Write a program which scraps the top 5 films on IMDB and dump this information into a movies.yml file:

# 1. Get the first 5 films on IMDB
# 2. Scrape the information about each movie
# 3. Put the information inside of a YAML file

# Methods:
# fetch_top_movies => an array of urls
# for each movie, scrape_movie(url)

movie_urls = fetch_top_movies

movie_infos = movie_urls.map do |url|
  scrape_movie(url)
end

File.open('movies.yml', 'w') do |f|
  f.write(movie_infos.to_yaml)
end
