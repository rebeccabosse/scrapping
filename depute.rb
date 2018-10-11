require 'nokogiri'
require 'open-uri'
require'pry'


PAGE_URL = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"


def depute
  doc = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
    name= doc.xpath('//*[@id="deputes-list"]/div/ul/li/a').map{|item| item.text}
    url=doc.xpath('//*[@id="deputes-list"]/div/ul/li/a').map{|item| "http://www2.assemblee-nationale.fr#{item["href"]}"}
    n=0
  emails=Array.new
  while n<url.length
  webpage = Nokogiri::HTML(open(url[n]))
  emails<<webpage.xpath('//dd[4]/ul/li[1]/a').map{|item| item["href"]}.join.gsub("mailto:","")
  n+=1
end
name.map!{|item| "Nom #{item}"}
emails.map!{|item| "email :#{item}"}
puts name.zip(emails)

end
depute
