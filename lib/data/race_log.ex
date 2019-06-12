defmodule Data do
@moduledoc """
Module to define all data
that feeds tha application
"""
  def parser do
    File.stream!("public/race_log.csv")
    |> CSV.decode!
    |> transform_data()
  end

  defp transform_data(data) when not is_list(data) do
    [_ | d] = Enum.to_list(data)
    transform_data(d)
  end

  defp transform_data(data) when is_list(data) do
    Enum.map(data, fn [_c, id, name, velocity, time, lap] ->
      %{
        id: String.to_integer(id),
        name: name,
        time: Time.from_iso8601!(time),
        lap: String.to_integer(lap),
        velocity: String.to_float(velocity)
      }
    end)
  end

  def writer(result) do
    result
    |> Enum.map(&format_regs/1)
    |> Service.FileSys.make_csv(csv_headers(), "output", "race")
  end

  defp csv_headers() do
    ["position, pilot, time, diff, laps_completed, avg_velocity, best_lap, best_lap_time\n"]
  end

  defp format_regs(reg) do
    id_str = String.pad_leading(to_string(reg.id), 2, "0")
    "#{reg.position},#{id_str} - #{reg.name},#{reg.time}, +#{reg.diff}, #{reg.acc_lap}, #{reg.avg_velocity}, #{reg.best_lap}, #{reg.best_lap_time}\n"
  end

  def race_log_mocked do
    [
      %{
        id: 1,
        name: "Barrichelo",
        lap: 1,
        time: Time.from_iso8601!("00:01:42.987"),
        velocity: 44.275
      },
      %{
        id: 2,
        name: "Vettel",
        lap: 1,
        time: Time.from_iso8601!("00:01:40.987"),
        velocity: 44.275
      }
    ]
  end
end
