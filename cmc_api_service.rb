require 'rest-client'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'byebug'

BASE_URL = "https://coinmarketcap.com/currencies/"

def fetch_coin_urls
  api_result = RestClient.get "https://api.coinmarketcap.com/v2/listings/"
  parsed_api_result = JSON.parse(api_result)
  listings = parsed_api_result["data"]
  first_listings = listings.first(5)

  urls = []

  listings.each do |coin|
    urls << url = BASE_URL + coin["website_slug"] + "/#markets"
  end
  urls
end

def fetch_trading_volume_per_coin(url)
  p url
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  table = html_doc.search("#markets-table")
  # Get info from first row:

  # exchange  = # TODO
  volume    = table.search(".volume").first
  pair_1    = volume.attributes[1]
  pair_2    = volume.attributes[2]
  byebug
end

fetch_trading_volume_per_coin(fetch_coin_urls[0])
