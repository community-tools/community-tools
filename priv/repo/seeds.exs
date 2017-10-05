# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CommunityTools.Repo.insert!(%CommunityTools.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

CommunityTools.EventQueries.create(CommunityToolsBackend.Events.changeset(%CommunityToolsBackend.Events{}, %{date: "2017-05-23 09:00:00", title: "Summer Codefest", description: "Omaha, NE"}))
CommunityTools.EventQueries.create(CommunityToolsBackend.Events.changeset(%CommunityToolsBackend.Events{}, %{date: "2017-06-19 00:00:00", title: "Charles Spurgeon's Birthday", description: "London"}))
