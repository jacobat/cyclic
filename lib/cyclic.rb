$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Cyclic
  VERSION = '0.0.2'
  
  # A cyclic buffer, that will discard elements as the buffer grows
  # full.
  class Buffer
    include Enumerable

    # Create a buffer holding the given _size_ number of elements
    def initialize(size)
      @size = size
      @buffer = []
    end

    # Push any number of elements onto the buffer
    def push(*elements)
      @buffer.push(*elements)
      @buffer = @buffer[-@size, @size] if(@buffer.size > @size)
    end

    alias_method :<<, :push

    # Return the contents of the buffer as an array
    def read
      @buffer
    end
    
    # Loop over each element in the buffer
    def each(&blk)
      @buffer.each(&blk)
    end
  end
end

