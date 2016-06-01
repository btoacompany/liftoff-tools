class Crawler
  def execute
    @doc = Nokogiri::HTML(open(@url))
    @doc.encoding = "utf-8"

    @xpaths.each { | k, v | @xpaths[k] = @doc.xpath(v).first.inner_html }
  end
end
