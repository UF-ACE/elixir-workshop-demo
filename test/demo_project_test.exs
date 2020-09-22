defmodule DemoProjectTest do
  use ExUnit.Case
  doctest DemoProject

  test "greets the world" do
    assert DemoProject.hello() == :world
  end
end
