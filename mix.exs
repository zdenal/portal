defmodule Portal.MixProject do
  use Mix.Project

  def project do
    [
      app: :portal,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      source_url: "https://github.com/zdenal/portal.git",
      description: "Test for publishing package from https://howistart.org/posts/elixir/1/"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Portal.Application, []}
    ]
  end

  def package do
  [
    name: "portal_test_zdenal",
    licenses: ["Apache 2.0"],
    maintainers: ["Zdenko Nevrala"],
    links: %{"GitHub" => "https://github.com/zdenal/portal.git"}
  ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:ex_doc, "~> 0.19.1", only: :dev},
      {:earmark, "~> 1.2", only: :dev}
    ]
  end
end
