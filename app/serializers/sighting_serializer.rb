class SightingSerializer < ActiveModel::Serializer
  attributes :day, :time, :city, :state, :shape, :duration, :summary
  belongs_to :month
end
