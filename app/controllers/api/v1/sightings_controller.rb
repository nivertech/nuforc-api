module Api
  module V1
    class SightingsController < ApplicationController
      # GET /sightings
      # GET /sightings.json
      def index
        @sightings = Sighting.all

        render json: @sightings
      end

      # GET /sightings/1
      # GET /sightings/1.json
      def show
        @sighting = Sighting.find(params[:id])

        render json: @sighting
      end

      def day
        :year = DateTime.strftime(:seen_when, '%Y')
        :month = DateTime.strftime(:seen_when, '%m')
        :day = DateTime.strftime(:seen_when, '%d')
        
        day = Sighting.where(year: params[:year], month: params[:month], day: params[:day])
        render json: day
      end
    end
  end
end
