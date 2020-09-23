defmodule Ims.TupleExtensions do
  def join(tuple, separator \\ ".") do
    tuple
    |> Tuple.to_list()
    |> Enum.join(separator)
  end
end
