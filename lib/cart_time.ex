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
end
