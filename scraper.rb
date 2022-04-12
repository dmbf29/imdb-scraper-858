require 'nokogiri'
require 'open-uri'

def fetch_top_movies
  # we need the url for the top movies (https://www.imdb.com/chart/top)
  url = 'https://www.imdb.com/chart/top'
  # open the url to get html back
  html = URI.open(url).read
  # give the html to Nokogiri to change to Nokogiri objects
  doc = Nokogiri::HTML(html)
  # search the objects for the first 5 urls (title name)
  doc.search('.titleColumn a').first(5).map do |element|
    path = element.attribute('href').value
    "https://www.imdb.com#{path}"
  end
  # return an array of the urls
end

def scrape_movie(url)
  html_content = URI.open(url, 'Accept-Language' => 'en-US').read
  doc = Nokogiri::HTML(html_content)
  title = doc.search('h1').text.strip
  storyline = doc.search('.sc-16ede01-0').text.strip
  year = doc.search('.sc-8c396aa2-2').first.text.strip.to_i
  cast = doc.search('.sc-11eed019-1').first(3).map do |element|
    element.text.strip
  end
  director = doc.search('.ipc-metadata-list-item__list-content-item').first.text.strip
  {
    title: title,
    storyline: storyline,
    year: year,
    cast: cast,
    director: director
  }
end
