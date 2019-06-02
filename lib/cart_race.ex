defmodule CartRace do
  @moduledoc """
  Documentation for Cart Race.
   caio.chedid@gympass.com
  """

  @doc """
  Returns the race result based in a
  result map, that contains average
  velocity, race time, best lap
  agrouped by pilot
  """
  def result do
    Data.race_log()
    |> Enum.group_by(& &1.id)
    |> Enum.map(& reducer/1)
    |> enumerate_position()
  end

  @doc """
  Sort by position the race result
  """
  @spec enumerate_position(any) :: [any]
  def enumerate_position(res) do
    res
    |> Enum.sort_by(& &1.time)
    |> Enum.with_index
    |> Enum.map(& include_position/1)
  end

  defp reducer({_id, pilots}, laps \\ 4) do
    pilots
    |> Enum.reduce_while(%{}, fn res, acc ->
      if res.lap <= laps,
        do: calculate(res, acc),
        else: {:halt, acc}
    end)
  end

  defp calculate(res, acc) do
    {:cont,
      case Enum.count(acc) do
        0 -> {res, ~T[00:00:00.000], res.velocity, 0}
        _ ->
          velox = acc.velocity + res.velocity
          avg_velox = velox / res.lap
          {res, acc.time, velox, avg_velox}
      end
      |> result_map()
    }
  end

  defp include_position({pilot, i}), do:
    pilot |> Map.put(:position, (i + 1))

  defp result_map({res, timing, velox, avg_velox}) do
    %{
      id: res.id,
      name: res.name,
      time: CartTime.add_time(timing, res.time),
      completed_laps: res.lap,
      velocity: velox,
      avg_velocity: avg_velox
    }
  end
end
