require 'nokogiri'
require 'open-uri'


def get_the_email_of_a_townhal_from_its_webpage(uri)
	doc = Nokogiri::HTML(open(uri))
	doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |node|
	  return node.text
	end
end
get_the_email_of_a_townhal_from_its_webpage("http://annuaire-des-mairies.com/95/vaureal.html")

def get_all_the_urls_of_val_doise_townhalls
  doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  #p et a =pour prendre en compte tous les liens
url_array= doc.xpath('//p/a').map{|link|link["href"]}.map{|link|"http://annuaire-des-mairies.com#{link[1..-1]}" }
    name_mairie=doc.xpath('//p/a').map{|link| link.text}
    n =0
  url_array2=Array.new
  while n<url_array.length
    url_array2<<get_the_email_of_a_townhal_from_its_webpage(url_array[n])
    n=n+1
  end
  puts name_mairie.zip(url_array2)
 end
get_all_the_urls_of_val_doise_townhalls



def perfom
  get_the_email_of_a_townhal_from_its_webpage(get_all_the_urls_of_val_doise_townhalls)
end
perfom
