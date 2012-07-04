require 'yaml'
require File.expand_path("../cbc", __FILE__)
require File.expand_path("../ctr", __FILE__)

def main(test_cases)
  test_cases.each do |test_case|
    cipher =
      case test_case["mode"]
      when "cbc"
        CBC.new(test_case["key"].hex_to_ascii)
      when "ctr"
        CTR.new(test_case["key"].hex_to_ascii)
      else STDERR.puts "Invalid mode: #{test_case.mode}"
      end
    puts cipher.decrypt(test_case["ciphertext"].hex_to_ascii)
  end
end

main(YAML.load(ARGF.read))
