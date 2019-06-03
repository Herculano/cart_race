defmodule CartTime do

  def add_time(timing, actual_time) do
    timing
    |> Time.add(CartTime.to_microseconds(actual_time), :microsecond)
    |> Time.truncate(:millisecond)
  end

  def to_microseconds(%{
    calendar: Calendar.ISO,
    hour: 0,
    minute: 0,
    second: 0,
    microsecond: {0, _}
  }) do
    0
  end

  def to_microseconds(time) do
    iso_days = {0, to_day_fraction(time)}
    Calendar.ISO.iso_days_to_unit(iso_days, :microsecond)
  end

  defp to_day_fraction(%{
    hour: hour,
    minute: minute,
    second: second,
    microsecond: {_, _} = microsecond,
    calendar: calendar
  }) do
    calendar.time_to_day_fraction(hour, minute, second, microsecond)
  end

  def microseconds_to_time(duration) do

      microseconds = rem(duration, 1000000) / 1000
      seconds = rem(Kernel.trunc(duration / 100000), 60)
      minutes = rem(Kernel.trunc(duration / (1000000 * 60)), 60)
      hours = rem(Kernel.trunc(duration / (100000 * 60 * 60)), 24)

      hours = if hours < 10, do:  "0" <> to_string(hours), else: to_string(hours)
      minutes = if minutes < 10, do: "0" <> to_string(minutes), else: to_string(minutes)
      seconds = if seconds < 10, do: "0" <> to_string(seconds), else: to_string(seconds)

      hours = String.to_integer(hours)
      minutes = String.to_integer(minutes)
      seconds = String.to_integer(seconds)
      microseconds = Kernel.trunc(microseconds) * 1000

      {:ok, time} = Time.new(hours, minutes, seconds, microseconds)

      time |> Time.truncate(:millisecond)

  end
end

# t = Time.from_iso8601!("00:01:39.987")
# duration = CartTime.to_microseconds(t)
# CartTime.microseconds_to_time(duration)
