require "test_helper"

class Example::MyExampleTest < ActiveSupport::TestCase
  def test_the_truth
    assert true
  end

  def test_call
    result = Example::MyExample.call("MESSAGE")

    assert_equal("MESSAGE", result.result)
    assert(result.success?)
  end
end
