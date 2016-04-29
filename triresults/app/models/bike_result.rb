class BikeResult < LegResult
  field :mph, as: :mph, type: Float

  def calc_ave
    if event && secs && event.miles
      self.mph = event.miles / secs * 3600
    end
  end

end
