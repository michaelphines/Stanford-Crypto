require "crypt/stringxor"
require "fast-aes"
require File.expand_path("../../lib/string_extensions", __FILE__)

class CTR
  def initialize(key)
    @cipher = FastAES.new(key.hex_to_ascii)
    @blocksize = key.length
  end

  def decrypt(ciphertext, iv = nil)
    if iv.nil?
      iv = ciphertext[0...@blocksize]
      ciphertext = ciphertext[@blocksize..-1]
    end

    return "" if iv.nil? || iv.empty? || ciphertext.nil? || ciphertext.empty?

    block = ciphertext[0...@blocksize].hex_to_ascii
    decrypted = @cipher.encrypt(iv.hex_to_ascii)
    plaintext = block ^ decrypted

    iv = (iv.to_i(16) + 1).to_s(16)
    plaintext += decrypt(ciphertext[@blocksize..-1], iv)
  end
end
