class String
  def uc_first
    self.sub(/^(.)/) { $1.capitalize }
  end
end