module StringExtensions
  def self.included(base)
    base.class_eval do
      include StringExtensions::InstanceMethods
      alias_method "next_without_mode", "next"
      alias_method "next", "next_with_mode"
    end
  end

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

    def next_with_mode(mode = :default)
      return next_without_mode if mode == :default
      if mode == :binary
        hex = self.ascii_to_hex
        int = hex.to_i(16) + 1
        int.to_s(16).hex_to_ascii
      else
        raise ArgumentError.new("Invalid mode '#{mode.inspect}' for next")
      end
    end
  end
end

String.send :include, StringExtensions
