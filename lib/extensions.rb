class Array
  def to_csv
    "\"#{self.to_a.join "\";\""}\""
  end
end
