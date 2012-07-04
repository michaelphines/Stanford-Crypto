require "crypt/stringxor"
require "fast-aes"
require File.expand_path("../../lib/string_extensions", __FILE__)

class CTR
  def initialize(key)
    @cipher = FastAES.new(key)
    @blocksize = key.length
  end

  def decrypt(ciphertext, iv = nil)
    if iv.nil?
      iv = ciphertext[0...@blocksize]
      ciphertext = ciphertext[@blocksize..-1]
    end

    return "" if iv.nil? || iv.empty? || ciphertext.nil? || ciphertext.empty?

    block = ciphertext[0...@blocksize]
    decrypted = @cipher.encrypt(iv)
    plaintext = block ^ decrypted

    plaintext += decrypt(ciphertext[@blocksize..-1], iv.next(:binary))
  end
end
