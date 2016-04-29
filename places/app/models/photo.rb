class Photo
  attr_accessor :id, :location
  attr_writer :contents

  def initialize(hash=nil)
    @id = hash[:_id].to_s unless hash.nil? or hash[:_id].nil?
    @location = Point.new hash[:metadata][:location] unless hash.nil? or hash[:metadata].nil?
    @place = hash[:metadata][:place] unless hash.nil? or hash[:metadata].nil?
  end

  def self.all(offset=nil, limit=nil)
    view = self.mongo_client.database.fs.find
    view = view.skip(offset) unless offset.nil?
    view = view.limit(limit) unless limit.nil?
    view.map {|doc| Photo.new(doc)}
  end

  def self.find id
    doc = self.mongo_client.database.fs.find(:_id => BSON::ObjectId.from_string(id)).first
    doc.nil? ? nil : Photo.new(doc)
  end

  def self.find_photos_for_place place_id
    place_id = BSON::ObjectId.from_string(place_id) if place_id.is_a? String
    self.mongo_client.database.fs.find({'metadata.place' => place_id})
  end

  def self.mongo_client
    Mongoid::Clients.default
  end

  def persisted?
    !@id.nil?
  end

  def save
    if !persisted?
      gps = EXIFR::JPEG.new(@contents).gps
      @contents.rewind
      @location = Point.new(:lng => gps.longitude, :lat => gps.latitude)
      description = {
        :content_type => 'image/jpeg',
        :metadata => {
          :location => @location.to_hash,
          :place => @place,
        },
      }
      grid_file = Mongo::Grid::File.new(@contents.read, description)
      id = self.class.mongo_client.database.fs.insert_one(grid_file)
      @id = id.to_s
    else
      _id = BSON::ObjectId.from_string(@id)
      doc = self.class.mongo_client.database.fs.find(:_id => _id).first
      doc[:metadata][:location] = @location.to_hash
      doc[:metadata][:place] = @place
      self.class.mongo_client.database.fs.find(:_id => _id).update_one(doc)
    end
  end

  def find_nearest_place_id max_distance
    Place.near(@location, max_distance).limit(1).projection({:_id => 1}).first[:_id]
  end

  def contents
    file = self.class.mongo_client.database.fs.find_one(:_id=>BSON::ObjectId.from_string(id))
    file.chunks.map {|c| c.data.data}.join
  end

  def destroy
    self.class.mongo_client.database.fs.find(:_id => BSON::ObjectId.from_string(@id)).delete_one
  end

  def place
    Place.find @place unless @place.nil?
  end

  def place=(p)
    case
    when p.is_a?(String)
      @place = BSON::ObjectId.from_string(p)
    when p.is_a?(BSON::ObjectId)
      @place = p
    when p.is_a?(Place)
      @place = BSON::ObjectId.from_string(p.id)
    #else
    #  raise Exception.new('Unexpected place type!')
    end
  end
end
