require 'progress_bar'
require File.expand_path("../../lib/string_extensions", __FILE__)
require File.expand_path("../stream_digest", __FILE__)

def main
  stream_hash = StreamDigest.new(ARGF)
  size = ARGF.file.size
  progress = ProgressBar.new(size, :percentage, :bar, :counter)

  while hash = stream_hash.next_hash
    progress.count = size - ARGF.pos
    progress.write
    last_hash = hash.ascii_to_hex
  end

  puts last_hash
end

main
