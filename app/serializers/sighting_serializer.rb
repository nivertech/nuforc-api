class SightingSerializer < ActiveModel::Serializer
  attributes :year, :month, :day, :time, :city, :state, :shape, :duration, :summary
end
