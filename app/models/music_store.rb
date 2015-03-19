class MusicStore < ActiveRecord::Base
  attr_accessible :address, :lat, :lon, :name, :stars
end
