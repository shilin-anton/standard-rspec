require "test_helper"

class StandardRspecTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Standard::Rspec::VERSION
  end
end
