module StringExtensions
  module InstanceMethods
    def printable?(char)
      0x20 <= self.ord && self.ord <= 0x7E
    end

    def hex_to_ascii
      [self].pack("H*")
    end

    def ascii_to_hex
      self.unpack("H*").first
    end
  end
end

String.send :include, StringExtensions::InstanceMethods