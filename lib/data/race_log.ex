defmodule Data do

  def race_log do
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
      },
      %{
        id: 3,
        name: "Mansel",
        lap: 1,
        time: Time.from_iso8601!("00:01:43.987"),
        velocity: 44.275
      },
      %{
        id: 1,
        name: "Barrichelo",
        lap: 2,
        time: Time.from_iso8601!("00:01:39.987"),
        velocity: 44.275
      },
      %{
        id: 2,
        name: "Vettel",
        lap: 2,
        time: Time.from_iso8601!("00:01:40.987"),
        velocity: 44.275
      },
      %{
        id: 3,
        name: "Mansel",
        lap: 2,
        time: Time.from_iso8601!("00:01:38.987"),
        velocity: 44.275
      },
      %{
        id: 1,
        name: "Barrichelo",
        lap: 3,
        time: Time.from_iso8601!("00:01:45.987"),
        velocity: 44.275
      },
      %{
        id: 2,
        name: "Vettel",
        lap: 3,
        time: Time.from_iso8601!("00:01:38.987"),
        velocity: 44.275
      },
      %{
        id: 3,
        name: "Mansel",
        lap: 3,
        time: Time.from_iso8601!("00:01:39.987"),
        velocity: 44.275
      },
      %{
        id: 3,
        name: "Mansel",
        lap: 4,
        time: Time.from_iso8601!("00:01:39.987"),
        velocity: 44.275
      }
    ]
  end
end
