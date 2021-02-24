defmodule Rocketpay.Numbers do
  ## Match pattern
  # def sum_from_file(filename) do
  #   # = não é operador de igual e sim de match
  #   file = File.read("#{filename}.csv")
  #   handle_file(file)
  # end

  # ## defp = função privada
  # defp handle_file({:ok, file}), do: file
  # defp handle_file({:error, _reason}), do: {:error, "Invalid file"}

  ## Using pipe
  def sum_from_file(filename) do
    ## Usando pipe, fará com que o retorno da primeira linha vá direto
    ## para o primeiro parametro da função da linha seguinte
    "#{filename}.csv"
    |> File.read()
    |> handle_file()
  end

  ## defp = função privada
  defp handle_file({:ok, result}) do
    result =
      result
      |> String.split(",")
      # O Stream fará com que o código seja inteligente, fazendo com que o compilador
      # faça o loop uma única vez, transformando assim em número e somando ao mesmo tempo.
      # Isso faz com que o código ganhe performace
      # |> Enum.map(fn number -> String.to_integer(number) end)
      |> Stream.map(fn number -> String.to_integer(number) end)
      |> Enum.sum()

    {:ok, %{result: result}}
    # Abaixo é o mesmo código sem pipe
    # result = String.split(result, ",")
    # result = Enum.map(result, fn number -> String.to_integer(number) end)
    # result = Enum.sum(result)
    # result
  end
  defp handle_file({:error, _reason}), do: {:error, %{message: "Invalid file"}}
end
