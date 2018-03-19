require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(File.read(index_url))
    doc.css(".student-card").collect do |roster_card|
      student_hash = {
        :name => roster_card.css(".student-name").text,
        :location => roster_card.css(".student-location").text,
        :profile_url => roster_card.css("a").attribute("href").text
      }
    end

  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    doc = Nokogiri::HTML(File.read(profile_url))
    links = doc.css(".social-icon-container").children.css("a").collect do |social_el|
      social_el.attribute("href").text
    end
    links.each do |link|
      if link.include?("twitter.com")
        student_hash[:twitter] = link
      elsif link.include?("linkedin.com")
        student_hash[:linkedin] = link
      elsif link.include?("github.com")
        student_hash[:github] = link
      else
        student_hash[:blog] = link
      end
    end
    if doc.css(".profile-quote")
      student_hash[:profile_quote] = doc.css(".profile-quote").text
    end
    if doc.css("div.bio-content.content-holder div.description-holder p")
      student_hash[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text
    end
    student_hash
  end

end
