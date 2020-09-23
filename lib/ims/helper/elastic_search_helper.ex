defmodule Ims.ElasticSearchHelper do
  alias Tirexs.HTTP, as: Api
  alias Ims.TupleExtensions

  def post(index, type, conn, map \\ %{}) do
    map = Map.delete(map, :__meta__)
    make_uri_for(index,type)
    |> Api.post(add_default_event_header(conn, map))
  end

  defp make_uri_for(index, type), do: "/#{index}/#{type}/"

  defp add_default_event_header(conn, map) do
    map
    |> Map.put(:'@timestamp' , to_string(NaiveDateTime.utc_now))
    |> Map.put(:client_ip, TupleExtensions.join(conn.remote_ip))
    |> Map.put(:http_verb, conn.method)
    |> Map.put(:request_path, conn.request_path)
  end
end
