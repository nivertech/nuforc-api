namespace :nuforc_scraper do

  require 'nokogiri'
  require 'open-uri'
  require 'date'

  url = 'http://www.nuforc.org/webreports/ndxevent.html'
  @doc = Nokogiri::HTML(open(url))

  desc "Retrieve past months and their total sightings count"
  task get_previous_months: :environment do
    months = []
    rows = @doc.css('tbody>tr')
    rows.shift # remove current month
    rows.pop # remove undefined sightings
    rows.each do |row|
      month = {
        :date => Date.strptime(row.css('a').text, '%m/%Y'),
        :count => row.css('font').last.text,
        :link => row.at_xpath('.//font/a/@href').to_s
      }
      months << month
    end

    puts months
  end

  desc "Get the current month and its current sightings total count"
  task get_current_month: :environment do
    first_row = @doc.css('tbody>tr').first

    return {
      date: first_row.css('a').text,
      count: first_row.css('font').last.text,
      link: first_row.at_xpath('.//font/a/@href').to_s
    }

  end

  desc "Scrape a month for sightings data"
  task scrape_sightings: :environment do
    # ndxeYYYYMM.html
    d = Date.parse(Time.now.to_s)
    d = d.strftime("%Y%m")
    month = "ndxe#{d}.html"

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
        posted_on: td[6].text
      }
      sightings << sighting
    end

    puts sightings
  end

end
