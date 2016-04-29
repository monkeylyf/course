class AddressComponent
  attr_accessor :long_name, :short_name
  attr_reader :types

  def initialize data
    @long_name = data[:long_name]
    @short_name = data[:short_name]
    @types = data[:types]
  end
end
