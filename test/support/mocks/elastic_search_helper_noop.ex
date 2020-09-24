defmodule Ims.ElasticSearchHelper.NOOP do
  def post(_a,_b,_c,_d \\ :noop), do: :noop
end
