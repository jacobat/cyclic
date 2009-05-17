require "test/unit"

require "cyclic"

class TestCyclic < Test::Unit::TestCase
  
  def setup
    @buffer = Cyclic::Buffer.new(5)
  end
  
  def test_should_put_items_into_buffer
    @buffer.push(1, 2, 3, 4, 5)
    assert_equal([1, 2, 3, 4, 5], @buffer.read)
  end
  
  def test_should_cycle_buffer_when_more_items_enter
    @buffer.push(1, 2, 3)
    @buffer.push(4, 5, 6)
    assert_equal([2, 3, 4, 5, 6], @buffer.read)
  end
  
  def test_should_allow_more_items_than_buffer_holds
    @buffer.push(*(1..10).to_a)
    assert_equal((6..10).to_a, @buffer.read)
  end
  
  def test_should_allow_other_classes_than_fixnums
    words = %w(one two three four five six)
    @buffer.push(*words)
    assert_equal(%w(two three four five six), @buffer.read)
  end
  
  def test_should_allow_serialization_to_yaml
    words = %w(one two three four five six)
    @buffer.push(*words)
    new_buffer = YAML::load(YAML::dump(@buffer))
    assert_equal(words[1,5], new_buffer.read)
  end
  
  def test_should_allow_pushing_after_deserialization
    words = %w(one two three four five six)
    @buffer.push(*words)
    new_buffer = YAML::load(YAML::dump(@buffer))
    new_buffer.push(*words)
    assert_equal(words[1,5], new_buffer.read)
  end
  
  def test_should_have_ltlt_as_alias_for_push
    words = %w(one two three four five six)
    words.each do |word|
      @buffer << word
    end
    assert_equal(words[1,5], @buffer.read)
  end
end