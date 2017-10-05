# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :community_tools,
  ecto_repos: [CommunityTools.Repo]

# Configures the endpoint
config :community_tools, CommunityToolsWeb.Endpoint,
  url: [host: "localhost"],
  http: [port: 80],
  secret_key_base: "",
  render_errors: [view: CommunityToolsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CommunityTools.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :community_tools, ecto_repos: [CommunityTools.Repo]
config :paper_trail, repo: CommunityTools.Repo

# Ueberauth Config
config :ueberauth, Ueberauth,
  base_path: "/sign-in", # default is "/auth"
  providers: [
    facebook: {Ueberauth.Strategy.Facebook, []},
    github: {Ueberauth.Strategy.Github, []},
    google: {Ueberauth.Strategy.Google, []},
    linkedin: {Ueberauth.Strategy.LinkedIn, []},
    auth0: {Ueberauth.Strategy.Auth0, []},
    identity: {Ueberauth.Strategies.Identity, [callback_methods: ["POST"]]},
  ]

config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
  client_id: "",
  client_secret: ""

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "",
  client_secret: ""

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: "",
  client_secret: ""

config :ueberauth, Ueberauth.Strategy.LinkedIn.OAuth,
  client_id: "",
  client_secret: ""

config :ueberauth, Ueberauth.Strategy.Auth0.OAuth,
  domain: "",
  client_id: "",
  client_secret: ""




config :guardian, Guardian,
  issuer: "CommunityTools.#{Mix.env}",
  ttl: {30, :days},
  verify_issuer: true, # optional
  verify_module: Guardian.JWT,  # optional
  secret_key: "",
  serializer: CommunityTools.GuardianSerializer,
  allowed_algos: ["HS512"], # optional
  allowed_drift: 2000,
  hooks: GuardianDb,
  permissions: %{
    default: [
      :read_profile,
      :write_profile,
      :read_token,
      :revoke_token,
    ],
  }

config :guardian_db, GuardianDb,
       repo: CommunityTools.Repo,
       schema_name: "guardian_tokens"

 config :arc,
   storage: Arc.Storage.Local
   #storage: Arc.Storage.S3, # or Arc.Storage.Local
   #bucket: {:system, "AWS_S3_BUCKET"} # if using Amazon S3

#secret_key: <guardian secret key>,
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
