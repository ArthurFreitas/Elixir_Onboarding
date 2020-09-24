defmodule Ims.RedisHelper.HTTPClient do
  alias Exredis.Api
  alias Poison

  def get(key) do
    case Api.get(key) do
      value when is_bitstring(value)-> {:ok, value}
      _ -> {:error, :not_json}
    end
  end

  def set(%{id: key} = struct) do
    set(key,struct)
  end

  def set(key,value) do
    case Poison.encode(value) do
      {:ok, json} -> Api.set(key,json)
      other -> other
    end
  end

  def del(%{id: key}) do
    del(key)
  end

  def del(key) do
    Api.del(key)
  end
end
