defmodule Ims.RedisHelper.NOOP do
  def get(_val), do: {:error, :noop}
  def del(_val), do: :noop
  def set(_val), do: :noop
end
