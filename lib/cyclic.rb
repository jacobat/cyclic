class Cyclic
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