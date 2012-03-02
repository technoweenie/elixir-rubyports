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
    read_file_chunk(io, false, cb)
  end

  defp read_file_chunk(io, acc, cb) do
    res = :file.read(io, 16384)
    case res do
    match: {:ok, data}
      if is_function(cb, 1) do
        cb.(data)
      else:
        acc = cb.(acc || [], data)
      end
      read_file_chunk(io, acc, cb)
    match: {:error, reason}
      :file.close(io)
      res
    match: :eof
      :file.close(io)
      acc
    end
  end
end

