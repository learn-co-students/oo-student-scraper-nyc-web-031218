require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    doc = Nokogiri::HTML(html)
    #name .student-name
    #location .student-location
    #profile .student-card a
    students = doc.css("div.student-card").map do |profile|
      {
        :name => profile.css("h4.student-name").text,
        :location => profile.css("p.student-location").text,
        :profile_url => profile.css("a").attribute('href').value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    doc = Nokogiri::HTML(html)
    #binding.pry
    #twitter url, linkedin url, github url, blog url, profile quote
    # doc.css(".social-icon-container").css("a")[0].attribute('href').value.include?("https://twitter.com/")
    @hash = {}
    doc.css(".social-icon-container").css("a").each do |x|
      if x.attribute('href').value.include?("twitter")
        @hash[:twitter] = x.attribute('href').value
      elsif x.attribute('href').value.include?("linkedin")
        @hash[:linkedin] = x.attribute('href').value
      elsif x.attribute('href').value.include?("github")
        @hash[:github] = x.attribute('href').value
      else
        @hash[:blog] = x.attribute('href').value
      end
    @hash[:profile_quote] = doc.css(".profile-quote").text
    @hash[:bio] = doc.css(".description-holder").css("p").text
    end
    @hash
    #binding.pry
  end

end

#Scraper.scrape_index_page('./fixtures/student-site/index.html')
Scraper.scrape_profile_page('./fixtures/student-site/students/ryan-johnson.html')
