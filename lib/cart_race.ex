defmodule CartRace do
  @moduledoc """
  Documentation for CartRace.
  """

  @doc """
    CartRace.result

  """
  def result do
    require IEx
    Data.race_log()
    |> Enum.group_by(& &1.id)
    |> Enum.map(fn {_, pilot} ->
      pilot |> Enum.reduce_while(%{}, fn x, acc ->
        if x.lap <= 4 do
          {timing, velox} =
            case Enum.count(acc) do
              0 -> {~T[00:00:00.000], 0}
              _ -> {acc.time, acc.velocity}
            end

          {:cont,
              %{
                id: x.id,
                name: x.name,
                time: CartTime.add_time(timing, x.time),
                lap: x.lap,
                velocity: velox + x.velocity
              }
          }
        else
          {:halt, acc}
        end
      end)
    end)
    |> Enum.sort_by(& &1.time)
  end




end
# 01:42.987 01:39.987 01:45.987 = 2: 09
