defmodule Rubin.MixProject do
  use Mix.Project

  def project do
    [
      app: :rubin,
      version: version(),
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        rubin: [
          include_executables_for: [:unix],
          steps: [:assemble, :tar],
          applications: [runtime_tools: :permanent],
          cookie: "simple_cookie_3256"
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Rubin.Application, []}
    ]
  end

  def version() do
    {hash, _} = System.cmd("git", ~w|rev-parse --short HEAD|)
    hash = String.trim(hash)

    {date, _} = System.cmd("git", ["log", "-1", "--pretty=format:%cd", "--date=format:%Y%m%d"])
    date = String.trim(date)

    "0.1.0+#{date}-#{hash}"
  end

  defp deps do
    [
      {:muontrap, "~> 0.6.0"}
    ]
  end
end
