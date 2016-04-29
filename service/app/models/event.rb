class Event
  include Mongoid::Document

  field :o, as: :order, type: Integer
  field :n, as: :name, type: String
  field :d, as: :distance, type: Float
  field :u, as: :units, type: String

  validates :order, presence: true
  validates :name, presence: true

  embedded_in :parent, polymorphic: true, touch: true

  def meters
    case self.units
    when /^meter(s?)/ then
      self.distance
    when /^kilometer(s?)/ then
      1000 * self.distance
    when /^yard(s?)/ then
      0.9144 * self.distance
    when /^mile(s?)/ then
      1609.344 * self.distance
    end
  end

  def miles
    case self.units
    when /^meter(s?)/ then
      self.distance * 0.000621371
    when /^kilometer(s?)/ then
      self.distance / 1.609344
    when /^yard(s?)/ then
      self.distance *  0.000568182
    when /^mile(s?)/ then
      self.distance
    end
  end
end
