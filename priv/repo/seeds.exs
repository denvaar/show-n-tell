# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ShowNTell.Repo.insert!(%ShowNTell.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ShowNTell.Repo
alias ShowNTell.User

andrew = %User{email: "mr.bator@gmail.com", first_name: "Andrew", last_name: "Bator", github_token: "123456789"}
         |> Repo.insert!

denver = %User{email: "uber.coder@gmail.com", first_name: "Denver", last_name: "Smith", github_token: "987654321"}
         |> Repo.insert!

Ecto.build_assoc(andrew, :talks, %{date: ~D[2018-07-01], title: "How to like your own code", description: "Best practices of writing code for humans", estimated_duration: 20})
|> Repo.insert!

Ecto.build_assoc(andrew, :talks, %{date: ~D[2018-07-01], title: "On yelling at your co-workers", description: "About some colorful language to be used while yelling", estimated_duration: 15})
|> Repo.insert!

Ecto.build_assoc(denver, :talks, %{date: ~D[2018-07-08], title: "Work/Life balance", description: "No such thing", estimated_duration: 60})
|> Repo.insert!
