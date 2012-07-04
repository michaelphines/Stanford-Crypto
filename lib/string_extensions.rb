module StringExtensions
  module InstanceMethods
    def printable?
      self.match(/^[\x20-\x7E]/)
    end

    def letter?
      self.match(/^[a-z]/i)
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