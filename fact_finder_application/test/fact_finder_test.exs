defmodule FactFinderTest do
  use ExUnit.Case
  import FactFinder

  setup_all do
    facts_file = "facts.txt"
    File.rm(facts_file)

    {:ok, facts_file: facts_file}
  end

  test "delete_fact returns error for non-existing fact" do
    assert delete_fact("is_a_dog (buddy)") == {:error, "Fact not found"}
  end
end
