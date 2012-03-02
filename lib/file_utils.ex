defmodule FileUtils do
  def pwd do
    pwd(nil)
  end

  def pwd(drive) do
    path = if drive do
      :file.get_cwd(drive)
    else:
      :file.get_cwd
    end

    case path do
    match: {:ok, dir}
      dir
    match: {:error, reason}
      IO.puts "Error: #{reason}"
      nil
    else:
      IO.puts "doh!"
      nil
    end
  end
end

