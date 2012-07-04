module StringExtensions
  module InstanceMethods
    def printable?
      0x20 <= self.ord && self.ord <= 0x7E
    end

    def letter?
      ((?A..?Z).to_a + (?a..?z).to_a).include?(self[0])
    end

    def hex_to_ascii
      [self].pack("H*")
    end

    def ascii_to_hex
      self.unpack("H*")[0]
    end
  end
end

String.send :include, StringExtensions::InstanceMethods