require File.expand_path("../many_time_pad", __FILE__)

def main(hex_ciphertexts)
  ciphertexts = hex_ciphertexts.map(&:hex_to_ascii)

  pad = ManyTimePad.new
  ciphertexts.each do |ciphertext|
    pad.add(ciphertext)
  end

  puts pad.decrypt(ciphertexts.last)
end

main(ARGF.readlines)
