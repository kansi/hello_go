defmodule RubinTest do
  use ExUnit.Case
  doctest Rubin

  test "greets the world" do
    assert Rubin.hello() == :world
  end
end
