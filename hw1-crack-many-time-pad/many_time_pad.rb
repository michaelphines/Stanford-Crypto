require "crypt/stringxor"
require File.expand_path("../../lib/string_extensions", __FILE__)

class ManyTimePad
  def initialize
    @ciphertexts = []
    @key_statistics = []
  end

  def infer_key
    @key_statistics.map do |char|
      char ? char.to_a.max_by(&:last).first : "\0"
    end.join
  end

  def add(ciphertext)
    @ciphertexts.each do |comparison|
      (ciphertext ^ comparison).chars.with_index do |xor, i|
        if xor.letter?
          @key_statistics[i] ||= Hash.new(0)
          [ciphertext[i], comparison[i]].each do |char|
            @key_statistics[i][char ^ " "] += 1
          end
        end
      end
    end

    @ciphertexts << ciphertext
  end

  def decrypt(ciphertext)
    ciphertext ^ infer_key
  end
end
