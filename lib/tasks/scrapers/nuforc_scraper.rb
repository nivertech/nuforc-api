require 'nokogiri'
require 'open-uri'
require 'date'

class NUFORCScraper

  url = 'http://www.nuforc.org/webreports/ndxevent.html'
  @doc = Nokogiri::HTML(open(url))

  def get_history
    months = []
    rows = @doc.css('tbody>tr')
    rows.pop
    rows.each do |row|
      month = {
        :date => Date.strptime(row.css('a').text, '%m/%Y'),
        :count => row.css('font').last.text,
        :link => row.at_xpath('.//font/a/@href').to_s
      }
      months << month
    end
  end

  # run on the first of every month
  # insert previous month sightings into db
  def get_previous_month_sightings
  end

  # should probably move current month methods
  # to the controller

  # current month w/ count from scraper
  def get_current_month_count
    first_row = @doc.css('tbody>tr').first

    return {
      date: first_row.css('a').text,
      count: first_row.css('font').last.text,
      link: first_row.at_xpath('.//font/a/@href').to_s
    }
  end

  def can_you_see_me
    puts "Yes, I can see you."
  end

  # current month from date
  def get_current_month
    # ndxeYYYYMM.html
    d = Date.parse(Time.now.to_s)
    d = d.strftime("%Y%m")
    month_url = "ndxe#{d}.html"

    get_sightings(month_url)
  end

  # get all sightings in current month
  def get_sightings(month)
    sightings = []
    # http://www.nuforc.org/webreports/ndxe201404.html
    month_url = "http://www.nuforc.org/webreports/#{month}"
    html = Nokogiri::HTML(open(month_url))

    rows = html.css('tbody>tr')
    rows.each do |row|
      td = row.css('td')
      sighting = {
        seen_when: DateTime.strptime(row.css('a').text, '%-m/%-d/%y %H:%M'),
        city: td[1].text,
        state: td[2].text,
        shape: td[3].text,
        duration: td[4].text,
        summary: td[5].text,
        post_on: td[6].text
      }
      sightings << sighting
    end
    puts sightings
  end

end
