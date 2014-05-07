class MonthSerializer < ActiveModel::Serializer
  attributes :year, :month, :count
  has_many :sightings
end
