namespace :nuforc_scraper do

  require 'nokogiri'
  require 'open-uri'
  require 'date'

  def get_previous_months
    url = 'http://www.nuforc.org/webreports/ndxevent.html'
    html = Nokogiri::HTML(open(url))

    month_links = []

    rows = html.css('tbody>tr')
    rows.pop
    rows.each do |row|
      link = row.at_xpath('.//font/a/@href').to_s
      month_links << link
    end

    month_links.each do |link|
      get_sightings(link)
    end
  end

  def get_sightings(month)

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

      DateTime.strptime(date, pattern)

      sighting = {
        year: year,
        month: month,
        day: day,
        time: time,
        city: td[1].text,
        state: td[2].text,
        shape: td[3].text,
        duration: td[4].text,
        summary: td[5].text
      }

      Sighting.create(sighting)
    end
  end

  desc "Retrieve past months and their total sightings count"
  task scrape_previous_months: :environment do
    get_previous_months
  end

  # desc "Get the latest month listed and its current sightings total count"
  # task get_latest_month: :environment do
    
  # end

  # desc "Scrape a month for sightings data"
  # task scrape_sightings: :environment do
    
  # end

end
