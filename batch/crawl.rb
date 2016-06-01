require 'nokogiri'
require 'open-uri'

class Monotaro > Crawler
  @url = "http://www.monotaro.com/p/0947/0745/"
  @xpaths = { 
    :title    => "//h1[@class='itd_prodname']//span[@class='fn']",
    :maker    => "//span[@class='itd_brand']//strong",
    :price    => "//dl[@class='itd_info_dl']",
    :code     => "//dl[@class='itd_info_dl']/dd[2]",
    :qty      => "//dl[@class='itd_info_dl']/dd[3]",
  }

  c = Crawler.new
  c.execute
end
