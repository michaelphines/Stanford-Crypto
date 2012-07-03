class String
  def hex_to_ascii
    [self].pack("H*")
  end

  def ascii_to_hex
    self.unpack("H*").first
  end
end