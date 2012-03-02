defmodule FileUtils do
  def pwd do
    pwd(nil)
  end

  def pwd(drive) do
    {:ok, dir} = if drive do
      :file.get_cwd(drive)
    else:
      :file.get_cwd
    end

    dir
  end

  def read(filename) do
    {:ok, data} = :file.read_file(filename)
    data
  end

  def read(filename, cb) when is_function(cb) do
    read(filename, [:raw], cb)
  end

  def read(filename, mode, cb) when is_function(cb) do
    {:ok, io} = :file.open(filename, mode)
    read_file_chunk(io, cb)
  end

  defp read_file_chunk(io, cb) do
    res = :file.read(io, 16384)
    case res do
    match: {:ok, data}
      cb.(data)
      read_file_chunk(io, cb)
    match: {:error, reason}
      :file.close(io)
      res
    match: :eof
      :file.close(io)
    end
  end
end

