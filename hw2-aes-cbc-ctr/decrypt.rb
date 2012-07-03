require 'yaml'
require './cbc'
require './ctr'

def main(test_cases)
  test_cases.each do |test_case|
    cipher =
      case test_case["mode"]
      when "cbc"
        CBC.new(test_case["key"])
      when "ctr"
        CTR.new(test_case["key"])
      else STDERR.puts "Invalid mode: #{test_case.mode}"
      end
    puts cipher.decrypt(test_case["ciphertext"])
  end
end

main(YAML.load(ARGF.read))