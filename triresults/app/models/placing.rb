class Placing
  attr_accessor :name, :place

  def initialize doc
    @name = doc[:name]
    @place = doc[:place]
  end

  def mongoize
    {:name => @name, :place => @place}
  end

  # Return a Ruby Hash.
  def self.mongoize object
    case object
    when nil then
      nil
    when Hash then
      object
    when Placing then
      object.mongoize
    end
  end

  # Return a instance of Point class.
  def self.demongoize object
    case object
    when nil then
      nil
    when Hash then
      Placing.new object
    when Placing then
      object
    end
  end

  def self.evolve object
    case object
    when nil then
      nil
    when Hash then
      object
    when Placing then
      object.mongoize
    end
  end
end
