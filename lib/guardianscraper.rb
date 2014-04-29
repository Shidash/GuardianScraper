require 'nokogiri'
require 'open-uri'
require 'json'

# Scraper for the articles about the NSA docs in the Guardian
class GuardianScraper
  def initialize(url)
    @url = url
  end

  # Download the article and save the text and other data
  def getArticle
    html = Nokogiri::HTML(open("http://www.theguardian.com/world/2013/jun/06/nsa-phone-records-verizon-court-order"))
    # Headline
    # Description
    # Date
    # Author
    # Documents linked
    @caption = html.css("div.caption").text
    @text = html.css("div#article-body-blocks").text
    @mediaorg = "The Guardian"
    @plaintext = html.css("div#article-body-blocks").text
  end

  # Convert to JSON
end

g = GuardianScraper.new("http://www.theguardian.com/world/2013/jun/06/nsa-phone-records-verizon-court-order")
g.getArticle
