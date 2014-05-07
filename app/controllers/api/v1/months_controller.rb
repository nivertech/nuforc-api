module Api
  module V1
    class MonthsController < ApplicationController
      # GET /months
      # GET /months.json
      def index
        @months = Month.all

        render json: @months
      end

      # GET /months/1
      # GET /months/1.json
      def show
        @month = Month.find(params[:id])

        render json: @month
      end

      # GET /YYYY
      # GET /YYYY.json
      def year
        year = Month.where(year: params[:year])
        render json: year
      end

      # GET /YYYY/MM
      # GET /YYYY/MM.json
      def month
        month = Month.where(year: params[:year], month: params[:month])
        render json: month
      end
    end
  end
end
