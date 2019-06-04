defmodule CartRaceTest do
  use ExUnit.Case
  doctest CartRace

  setup_all do
    {:ok, [empty_log: [], log: Data.race_log_mocked]}
  end

  test "results when no data is reached", %{empty_log: empty_log} do
    assert empty_log == []
  end

  test "results when data is reached", %{log: log} do
    assert log != []
  end
end
