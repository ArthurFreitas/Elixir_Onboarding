use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ims, Ims.Repo,
  database: "ims_test",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 1

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ims, ImsWeb.Endpoint,
  http: [port: 4002],
  server: false

# Mocks
config :ims, :redis_helper, Ims.RedisHelper.NOOP
config :ims, :elastic_search_helper, Ims.ElasticSearchHelper.NOOP

# Print only warnings and errors during test
config :logger, level: :warn
