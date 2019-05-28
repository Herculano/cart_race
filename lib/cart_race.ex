defmodule CartRace do
  @moduledoc """
  Documentation for Cart Race.
  """

  @doc """

  """
  def result do
    Data.race_log()
    |> Enum.group_by(& &1.id)
    |> Enum.map(& reducer/1)
    |> enumerate_position()
  end

  def enumerate_position(res) do
    res
    |> Enum.sort_by(& &1.time)
    |> Enum.with_index
    |> Enum.map(& include_position/1)
  end

  defp reducer({_id, pilots}, laps \\ 4) do
    pilots
    |> Enum.reduce_while(%{}, fn res, acc ->
      if res.lap <= laps do
        {timing, velox} =
          case Enum.count(acc) do
            0 -> {~T[00:00:00.000], 0}
            _ -> {acc.time, acc.velocity}
          end

        {:cont, result_map(res, timing, velox)}
      else
        {:halt, acc}
      end
    end)
  end

  defp include_position({pilot, i}), do:
    pilot |> Map.put(:position, (i + 1))

  defp result_map(res, timing, velox) do
    %{
      id: res.id,
      name: res.name,
      time: CartTime.add_time(timing, res.time),
      completed_laps: res.lap,
      velocity: velox + res.velocity
    }
  end
end
