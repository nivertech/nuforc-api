namespace :nuforc_scraper do

  require 'nokogiri'
  require 'open-uri'
  require 'date'

  def get_sightings(month)
    puts "Month Link: #{month}"

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
      # puts "#{month} >> Report: #{date} at #{time}"
      # sighting_url = "http://www.nuforc.org/webreports/#{sighting_href}"
      # sighting_html = Nokogiri::HTML(open(sighting_url))

      # begin
      #   full_summary = sighting_html.css('td')[1].text
      # rescue NoMethodError => e
      #   puts "#{e.message}, full_summary equals zero"
      #   full_summary = 0
      # end

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
        link: "http://www.nuforc.org/webreports/#{sighting_href}"
        # full_summary: full_summary
      }

      Sighting.create(sighting)
    end
  end

  def get_previous_months
    url = 'http://www.nuforc.org/webreports/ndxevent.html'
    html = Nokogiri::HTML(open(url))

    month_links = []

    rows = html.css('tbody>tr')

    d = Date.today.strftime("%m/%Y")
    if (html.xpath('.//tbody/tr[1]/td[1]/font/a').text == d)
      rows.shift
    end

    rows.pop
    rows.each do |row|
      href = row.at_xpath('.//font/a/@href').to_s
      month_links << href
    end

    month_links.each do |link|
      get_sightings(link)
    end
  end

  desc "Retrieve past months and their total sightings count"
  task scrape_previous_months: :environment do
    get_previous_months
  end

end
