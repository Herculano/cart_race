defmodule Service.FileSys do
  @moduledoc """
  Module that brings csv writers
  """

  def make_csv(registers, header, key, prefix \\ nil, path \\ "public")
  def make_csv(registers, header, key, prefix, path) do
    filename = "#{path}/#{prefix}_#{key}.csv"
    file = reserve_local_file(filename)

    registers
    |> put_csv_headers(header)
    |> Enum.each(&IO.write(file, &1))

    filename
  end

  defp put_csv_headers(list, header), do: header ++ list

  defp reserve_local_file(local_file) do
    File.open!(local_file, [:write, :utf8])
  end
end
