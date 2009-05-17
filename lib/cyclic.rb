$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Cyclic
  VERSION = '0.0.1'
  
  class Buffer
    def initialize(size)
      @size = size
      @buffer = []
    end

    def push(*elements)
      @buffer.push(*elements)
      @buffer = @buffer[-@size, @size] if(@buffer.size > @size)
    end

    alias_method :<<, :push

    def read
      @buffer
    end
  end
end

