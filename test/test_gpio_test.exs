defmodule TestGpioTest do
  use ExUnit.Case
  doctest TestGpio

  test "greets the world" do
    assert TestGpio.hello() == :world
  end
end
