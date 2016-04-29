class SwimResult < LegResult
  field :pace_100, as: :pace_100, type: Float

  def calc_ave
    if event && secs && event.meters
      self.pace_100 = 100 * secs / event.meters# / secs
    end
  end
end
