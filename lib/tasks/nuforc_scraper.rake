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
      datetime = row.css('a').text

      date = /\d{1,2}\/\d{1,2}\/\d{2}/.match(datetime).to_s
      time = /\d{2}\:\d{2}/.match(datetime).to_s

      date_obj = Date.strptime(date, "%m/%d/%y")

      m = date_obj.strftime('%m')
      d = date_obj.strftime('%d')
      y = date_obj.strftime('%Y')

      sighting_href = row.at_xpath('.//font/a/@href').to_s
      sighting_url = "http://www.nuforc.org/webreports/#{sighting_href}"
      sighting_html = Nokogiri::HTML(open(sighting_url))

      full_summary = sighting_html.css('td')[1].text

      sighting = {
        year: y,
        month: m,
        day: d,
        time: time,
        city: td[1].text,
        state: td[2].text,
        shape: td[3].text,
        duration: td[4].text,
        summary: td[5].text,
        full_summary: full_summary
      }

      Sighting.create(sighting)
    end

  end

  desc "Retrieve past months and their total sightings count"
  task scrape_previous_months: :environment do
    get_previous_months
  end

end
