class Point
  attr_accessor :longitude, :latitude

  def initialize json
    if json[:type]
      @latitude = json[:coordinates][1]
      @longitude = json[:coordinates][0]
    else
      @latitude = json[:lat]
      @longitude = json[:lng]
    end
  end

  def to_hash
    {"type": "Point", "coordinates": [@longitude, @latitude]}
  end
end
