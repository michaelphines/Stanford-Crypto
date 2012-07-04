require "crypt/stringxor"
require "fast-aes"
require File.expand_path("../../lib/string_extensions", __FILE__)

class CBC
  def initialize(key)
    @cipher = FastAES.new(key)
    @blocksize = key.length
  end

  def decrypt(ciphertext)
    iv = ciphertext[0...@blocksize]
    block = ciphertext[@blocksize...(@blocksize * 2)]

    return "" if iv.nil? || iv.empty? || block.nil? || block.empty?

    decrypted = @cipher.decrypt(block)
    plaintext = iv ^ decrypted
    plaintext += decrypt(ciphertext[@blocksize..-1])
  end
end
