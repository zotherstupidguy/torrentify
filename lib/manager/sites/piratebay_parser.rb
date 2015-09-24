#!/usr/bin/ruby

require_relative '../../model/torrent_model'

# Class responsible for parsing
# the page response from kickass
class PirateBayParser
  def initialize(page)
    @page = page
  end

  # Parse values from html
  module Parser
    def self.seeders(div)
      links = div.search(".//td[@align='right']")
      links[0].content if !links.nil? && !links[0].nil?
    end

    def self.leechers(div)
      links = div.search(".//td[@align='right']")
      links[1].content if !links.nil? && !links[1].nil?
    end

    def self.size(div)
      links = div.search(".//font[@class='detDesc']")
      value = ''
      links.each do |link|
        value = link.content[/#{'Size '}(.*?)#{', '}/m, 1]
      end
      value
    end

    def self.torrent_url(div)
      links = div.search(".//a[@title='Download this torrent using magnet']")
      value = ''
      links.each do |link|
        value = link.attributes['href']
      end
      value
    end

    def self.torrent_name(div)
      links = div.search(".//a[@class='detLink']")
      value = ''
      links.each do |link|
        value = link.content
      end
      value
    end
  end

  def main_divs
    divs = @page.search('.//tr')
    divs.each do |div|
      puts '-----------------'
      puts Parser.torrent_url(div)
      puts Parser.torrent_name(div)
      puts Parser.size(div)
      puts Parser.seeders(div)
      puts Parser.leechers(div)
    end
    divs
  end
end