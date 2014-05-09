module Api
  module V1
    class SightingsController < ApplicationController
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

      # GET /Rochester
      def city
        @sightings = Sighting.where(city: params[:city])

        render json: @sightings
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
