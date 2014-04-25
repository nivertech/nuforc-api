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
end
