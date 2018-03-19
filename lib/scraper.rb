require 'open-uri'
require 'pry'
require 'Nokogiri'
#student : page.css("div.student-card")
#name : student.css("div h4.student-name").text
#location : student.css("div p.student-location").text
#link: student.css("a").attribute("href").value

#social link : page.css(".social-icon-container a").attribute("href").text.slice(/\.(.*?)\./, 1)
#
#bio: page.css("div.description-holder p").text
#
class Scraper

  def self.get_page_html(page_url)
    html = File.read(page_url)
page = Nokogiri::HTML(html)
end

def self.students_html(index_url)
  page = get_page_html(index_url)
  page.css("div.student-card")
end

  def self.scrape_index_page(index_url)
students = students_html(index_url)
student_arr = []
students.each{|student|
student_arr.push({
  name: student.css("div h4.student-name").text,
  location: student.css("div p.student-location").text,
  profile_url: student.css("a").attribute("href").value
})
}
student_arr
  end

  def self.scrape_profile_page(profile_url)
    page = get_page_html(profile_url)
    result = {}
    social_arr = []
    i = 1
    while page.css("div.social-icon-container a[#{i}]").length != 0
      social_arr.push(page.css("div.social-icon-container a[#{i}]").attribute("href").text)
      i += 1
    end
  social_arr.each{|link|
       case link.slice(/\:(.*)\./, 1)
      when "//twitter"
         result[:twitter] = link
      when "//www.twitter"
        result[:twitter] = link
      when "//linkedin"
         result[:linkedin] = link
      when "//www.linkedin"
        result[:linkedin] = link
       when "//github"
         result[:github] = link
      when "//www.github"
        result[:github] = link
       else
         result[:blog] = link
       end
  }
    result[:bio] = page.css("div.description-holder p").text
    result[:profile_quote] = page.css("div.profile-quote").text
    result
  end


end
Scraper.scrape_profile_page("./fixtures/student-site/students/ruth-mesfun.html")
