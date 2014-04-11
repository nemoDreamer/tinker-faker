class Array
  def to_csv is_complex = false
    is_complex ? "\"#{self.to_a.join "\";\""}\"" : self.to_a.join(',')
  end
end
