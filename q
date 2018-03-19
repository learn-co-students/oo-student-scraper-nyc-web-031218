
[1mFrom:[0m /home/jdbean/code/labs/oo-student-scraper-nyc-web-031218/lib/scraper.rb @ line 13 Scraper.scrape_index_page:

     [1;34m8[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_index_page[0m(index_url)
     [1;34m9[0m: 
    [1;34m10[0m:   doc = [1;34;4mNokogiri[0m::HTML([1;34;4mFile[0m.read([31m[1;31m'[0m[31mfixtures/student-site/index.html[1;31m'[0m[31m[0m))
    [1;34m11[0m:   [1;34m# bindwing.pry[0m
    [1;34m12[0m:   doc.css([31m[1;31m"[0m[31m.student-card[1;31m"[0m[31m[0m).collect [32mdo[0m |roster_card|
 => [1;34m13[0m:     binding.pry
    [1;34m14[0m: 
    [1;34m15[0m:     roster_card.first.css([31m[1;31m"[0m[31m.student.card[1;31m"[0m[31m[0m).first
    [1;34m16[0m:     binding.pry
    [1;34m17[0m:   [32mend[0m
    [1;34m18[0m: 
    [1;34m19[0m: [32mend[0m

