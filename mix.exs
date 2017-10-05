defmodule CommunityTools.Mixfile do
  use Mix.Project

  def project do
    [app: :community_tools,
     version: "0.0.1",
     elixir: "~> 1.4",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {CommunityTools.Application, []},
     extra_applications: [:logger, :runtime_tools, :ueberauth, :ueberauth_auth0, :ueberauth_facebook, :ueberauth_github, :ueberauth_google, :ueberauth_linkedin, :guardian, :guardian_db, :slugger, :ecto_autoslug_field, :timex, :phoenix_timex, :font_awesome_phoenix, :paper_trail]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.3.0", override: true},
     {:phoenix_pubsub, "~> 1.0"},
     {:ecto, "~> 2.2", override: true},
     {:phoenix_ecto, "~> 3.2"},
     {:postgrex, ">= 0.13.2", override: true},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev, override: true},
     {:gettext, "~> 0.11"},
     {:cowboy, "~> 1.0"},
     {:oauth2, "~> 0.9.0", override: true},
     {:ueberauth, "~> 0.4.0"},
     {:ueberauth_identity, "~> 0.2.3"},
     {:ueberauth_auth0, "~> 0.2.0"},
     {:ueberauth_facebook, "~> 0.7.0"},
     {:ueberauth_github, "~> 0.4.1"},
     {:ueberauth_gitlab, "~> 0.1.0"},
     {:ueberauth_google, "~> 0.5.0"},
     {:ueberauth_linkedin, "~> 0.3.2"},
     {:ueberauth_slack, "~> 0.4.1"},
     {:guardian, "~> 0.14"},
     {:guardian_db, "~> 0.8.0"},
     {:comeonin, "~> 4.0"},
     {:canada, "~> 1.0.2"},
     {:canary, "~> 1.1"},
     {:timex, "~> 3.1", override: true},
     {:phoenix_timex, "~> 1.0", override: true},
     {:font_awesome_phoenix, "~> 0.1"},
     {:exrm, "~> 1.0.8"},
     {:distillery, "~> 1.1"},
     {:slugger, "~> 0.2.0"},
     {:ecto_autoslug_field, "~> 0.3.1"},
     {:arc, "~> 0.8.0"},
     {:arc_ecto, "~> 0.7.0"},
     {:cloak, "~> 0.3.2"},
     {:paper_trail, "~> 0.7.6"},
     {:uuid, "~> 1.1" },
     {:plug_redirect, "~> 0.1.2"}
   ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
