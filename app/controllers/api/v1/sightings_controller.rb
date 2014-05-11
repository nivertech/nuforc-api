module Api
  module V1
    class SightingsController < ApplicationController

      require 'nokogiri'
      require 'open-uri'
      require 'date'

      # GET /sightings
      def index
        @sightings = Sighting.all

        render json: @sightings
      end

      # GET /YYYY
      def year
        @sightings = Sighting.where(year: params[:year])

        render json: @sightings
      end

      # GET /YYYY/MM
      def month
        @sightings = Sighting.where(year: params[:year], month: params[:month])

        render json: @sightings
      end

      # GET /YYYY/MM/DD
      def day
        # need to check year and month
        @sightings = Sighting.where(year: params[:year], month: params[:month], day: params[:day])

        render json: @sightings
      end

      # GET /NY
      def state
        @sightings = Sighting.where(state: params[:state])

        render json: @sightings
      end

      # GET /NY/Rochester
      def city
        @sightings = Sighting.where(state: params[:state], city: params[:city])

        render json: @sightings
      end

      # GET /latest
      def current_month
        url = 'http://www.nuforc.org/webreports/ndxevent.html'
        html = Nokogiri::HTML(open(url))
        first_tr = html.css('tbody>tr')[0]
        month_href = first_tr.at_xpath('.//td/font/a/@href').to_s

        month_url = "http://www.nuforc.org/webreports/#{month_href}"
        month_html = Nokogiri::HTML(open(month_url))

        sightings = []

        rows = month_html.css('tbody>tr')
        rows.each do |row|
          td = row.css('td')
          datetime = row.css('a').text

          date = /\d{1,2}\/\d{1,2}\/\d{2}/.match(datetime).to_s
          time = /\d{2}\:\d{2}/.match(datetime).to_s

          date_obj = Date.strptime(date, "%m/%d/%y")

          m = date_obj.strftime('%m')
          d = date_obj.strftime('%d')
          y = date_obj.strftime('%Y')

          sighting_href = row.at_xpath('.//td/font/a/@href').to_s
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

          sightings << sighting
        end

        render json: sightings
      end

      private

      def default_serializer_options
        {
          root: false
        }
      end
    end
  end
end
