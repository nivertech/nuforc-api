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
    end
  end
end
