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
    articlehash = Hash.new
    html = Nokogiri::HTML(open(@url))

    # Gets misc data on article
    articlehash[:headline] = html.css('h1[itemprop="name headline  "]').text
    articlehash[:description] = html.css('div[itemprop="description"]').text
    articlehash[:date] = html.css('time[itemprop="datePublished"]').text
    articlehash[:author] = html.css("a.contributor").text
    articlehash[:published_by] = "The Guardian"                                                     
    articlehash[:caption] = html.css("div.caption").text

    # Gets list of documents linked to
    articlehash[:documents] = Array.new
    html.css('div[itemprop="description"]').css("a").each do |d|
      articlehash[:documents].push(d["href"])
    end
    
    # Gets text of article
    articlehash[:text] = html.css("div#article-body-blocks").text
    articlehash[:plaintext] = html.css("div#article-body-blocks").text

    JSON.pretty_generate(articlehash)
  end
end
