namespace :nuforc_scraper do

  require 'nokogiri'
  require 'open-uri'
  require 'date'

  url = 'http://www.nuforc.org/webreports/ndxevent.html'
  @doc = Nokogiri::HTML(open(url))

  desc "Retrieve past months and their total sightings count"
  task get_previous_months: :environment do
    rows = @doc.css('tbody>tr')
    rows.shift # remove current month
    rows.pop # remove undefined sightings
    rows.each do |row|
      # convert string to date object
      date = Date.strptime(row.css('a').text, '%m/%Y')
      # get year and month from date object
      year = date.strftime("%Y")
      month = date.strftime("%m")

      group = {
        :year => year.to_s,
        :month => month.to_s,
        :count => row.css('font').last.text,
        :link => row.at_xpath('.//font/a/@href').to_s
      }

      Month.create(group)
    end
  end

  desc "Get the latest month listed and its current sightings total count"
  task get_latest_month: :environment do
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
      date = row.css('a').text

      if (DateTime.strptime(date, '%-m/%-d/%y %H:%M'))
        pattern = '%-m/%-d/%y %H:%M'
      else 
        pattern = '%-m/%-d/%y'
      end

      sighting = {
        seen_when: DateTime.strptime(date, pattern),
        city: td[1].text,
        state: td[2].text,
        shape: td[3].text,
        duration: td[4].text,
        summary: td[5].text,
      }
      sightings << sighting
    end

    puts sightings
  end

end
