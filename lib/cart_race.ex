defmodule CartRace do
  @moduledoc """
  Documentation for Cart Race.
  """

  @doc """
  Returns the race result based in a
  result map, that contains average
  velocity, race time, best lap
  agrouped by pilot
  """
  def result do
    parse_reducer()
    |> enumerate_position()
    |> set_diff()
    |> encode_data_result()
  end

  @spec parse_reducer :: [any]
  def parse_reducer do
    Data.parser()
    |> Enum.group_by(& &1.id)
    |> Enum.map(& reducer/1)
  end

  @doc """
  Sort by position the race result
  """
  def enumerate_position(res) do
    res
    |> Enum.sort(&Time.compare(&1.time, &2.time) == :lt)
    |> Enum.sort_by(& &1.acc_lap, &>=/2)
    |> Enum.with_index
    |> Enum.map(& include_position/1)
  end

  @spec set_diff(nonempty_maybe_improper_list, any) :: [...]
  def set_diff(grid, min_laps \\ 4) do
    [winner | squad] = grid

    [Map.put(winner, :diff, 0) |
      squad
      |> Enum.map(&analize_diff(&1, winner.time, min_laps))
    ]
  end

  def encode_data_result(res), do: Data.writer(res)

  defp analize_diff(pilot, w_time, min_laps) do
    diff =
      case pilot.acc_lap == min_laps do
        true ->
          Time.diff(pilot.time, w_time, :microsecond)
          |> CartTime.microseconds_to_time()
        _-> 0
      end
    Map.put(pilot, :diff, diff)
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
        0 -> {res, ~T[00:00:00.000], res.velocity, 0, {res.lap, res.time}}
        _ ->
          velox = acc.velocity + res.velocity
          avg_velox =
            (velox / res.lap)
            |> Float.round(3)

          best_lap =
            if res.time < acc.best_lap_time,
              do: {res.lap, res.time},
              else:  {acc.best_lap, acc.best_lap_time}

          {res, acc.time, velox, avg_velox, best_lap}
      end
      |> result_map()
    }
  end

  defp include_position({pilot, i}), do:
    pilot
    |> Map.put(:position, (i + 1))
    |> Map.drop([:velocity])

  defp result_map({res, timing, velox, avg_velox, {bl, blt}}) do
    %{
      id: res.id,
      name: res.name,
      time: CartTime.add_time(timing, res.time),
      acc_lap: res.lap,
      velocity: velox,
      avg_velocity: avg_velox,
      best_lap: bl,
      best_lap_time: blt
    }
  end
end
