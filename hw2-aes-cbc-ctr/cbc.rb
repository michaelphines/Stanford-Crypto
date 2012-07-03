require 'crypt/stringxor'
require 'fast-aes'
require './hex_tools'

class CBC
  def initialize(key)
    @cipher = FastAES.new(key.hex_to_ascii)
    @blocksize = key.length
  end

  def decrypt(ciphertext)
    iv = ciphertext[0...@blocksize]
    block = ciphertext[@blocksize...(@blocksize * 2)]

    return "" if iv.nil? || iv.empty? || block.nil? || block.empty?

    decrypted = @cipher.decrypt(block.hex_to_ascii)
    plaintext = iv.hex_to_ascii ^ decrypted
    plaintext += decrypt(ciphertext[@blocksize..-1])
  end
end
