class Place
  include ActiveModel::Model

  attr_accessor :id, :address_components, :formatted_address, :location

  def initialize hash
    @id = hash[:_id].to_s
    @formatted_address = hash[:formatted_address]
    @location = Point.new hash[:geometry][:geolocation]
    if hash[:address_components].nil?
      @address_components = []
    else
      @address_components = hash[:address_components].map {|ac| AddressComponent.new ac}
    end
  end

  def persisted?
    !@id.nil?
  end

  def destroy
    _id = BSON::ObjectId(@id)
    self.class.collection.find(_id: _id).delete_many
  end

  def self.mongo_client
    Mongoid::Clients.default
  end

  def self.collection
    self.mongo_client[:places]
  end

  def self.load_all file_handler
    data = file_handler.read
    json_data = JSON.parse(data)
    self.collection.insert_many(json_data)
  end

  def self.find_by_short_name name
    query_clause = {"address_components.short_name": name}
    self.collection.find(query_clause)
  end

  def self.to_places view
    view.map{|r| Place.new r}
  end

  def self.find id
    _id = BSON::ObjectId(id)
    record = self.collection.find(_id: _id).first
    if record.nil?
      nil
    else
      Place.new(record)
    end
  end

  def self.all(offset=nil, limit=nil)
    records = self.collection.find
    records = records.limit(limit) unless limit.nil?
    records = records.skip(offset) unless offset.nil?
    records.map{ |r| Place.new r }
  end

  def self.get_address_components(sort=nil, offset=nil, limit=nil)
    query_clause = [
      {
        :$project => {
          :_id => 1,
          :address_components => 1,
          :formatted_address => 1,
          :geometry => {
            :geolocation => 1
          }
        }
      },
      {:$unwind => '$address_components'},
    ]
    query_clause << {:$sort => sort} unless sort.nil?
    query_clause << {:$skip => offset} unless offset.nil?
    query_clause << {:$limit => limit} unless limit.nil?

    self.collection.aggregate(query_clause)
  end

  def self.get_country_names
    query_clause = [
      {
        :$project => {
          :_id => 0,
          :address_components => {
            :long_name => 1,
            :types => 1
          },
        }
      },
      {
        :$unwind => '$address_components'
      },
      {
        :$match => {
          'address_components.types' => 'country',
        }
      },
      {
        :$group => {
          :_id => '$address_components.long_name',
          :count => {
            :$sum => 1,
          },
        },
      },
    ]

    self.collection.aggregate(query_clause).to_a.map {|h| h[:_id]}
  end

  def self.find_ids_by_country_code country_code
    query_clause = [
      {
        :$unwind => '$address_components'
      },
      {
        :$project => {
          :_id => 1,
          :address_components => {
            :short_name => 1,
            :types => 1,
          }
        }
      },
      {
        :$match => {
          'address_components.types' => 'country',
          'address_components.short_name' => country_code,
        }
      },
    ]

    self.collection.aggregate(query_clause).to_a.map {|h| h[:_id].to_s}
  end

  def self.create_indexes
    self.collection.indexes.create_one('geometry.geolocation' => Mongo::Index::GEO2DSPHERE)
  end

  def self.remove_indexes
    self.collection.indexes.drop_one('geometry.geolocation' => Mongo::Index::GEO2DSPHERE)
  end

  def self.near(point, max_meters=nil)
    query_clause = {
      'geometry.geolocation' => {
        '$near' => point.to_hash
      },
    }
    query_clause['geometry.geolocation'][:$maxDistance] = max_meters.to_i unless max_meters.nil?
    self.collection.find(query_clause)
  end

  def near(max_distance_threshold=nil)
    view = self.class.near(@location, max_distance_threshold)
    self.class.to_places view
  end

  def photos(offset=nil, limit=nil)
    view = Photo.find_photos_for_place(@id)
    view = view.skip(offset) unless offset.nil?
    view = view.limit(limit) unless limit.nil?
    view.map {|doc| Photo.new doc}
  end
end
