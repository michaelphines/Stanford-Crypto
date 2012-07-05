require "digest/sha2"

class StreamDigest
  def initialize(stream, block_size=1024)
    @stream = stream.binmode
    @block_size = block_size
    @current_hash = ""
    @stream.seek(0, IO::SEEK_END)
  end

  def next_block
    return nil if @stream.pos == 0

    length = @stream.pos % @block_size
    length = @block_size if length == 0

    @stream.seek(-length, IO::SEEK_CUR)
    block = @stream.read(length)
    @stream.seek(-length, IO::SEEK_CUR)

    block
  end

  def next_hash
    block = next_block
    @current_hash = Digest::SHA2.digest(block + @current_hash) if block
  end
end
