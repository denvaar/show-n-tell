defmodule ShowNTellWeb.Resolvers.Content do
  use ShowNTellWeb.ConnCase

  alias ShowNTell.Talk
  alias ShowNTellWeb.Resolvers.Content

  @talk %{
    title: "Goodness in programming",
    description: "How goodness helps programming",
    estimated_duration: 59,
    talk_date: ~D[2018-07-01]
  }

  describe "get_talk/3" do
    test "loads one talk by id" do
      {:ok, talk} = Talk.create_talk(@talk)
      assert Content.get_talk(nil, %{id: talk.id}, nil) == {:ok, talk}
    end

    test "returns nil of talk doesn't exist" do
      assert Content.get_talk(nil, %{id: -1}, nil) == {:ok, nil}
    end
  end

  describe "talks/3" do
    test "returns all found talks" do
      {:ok, talk} = Talk.create_talk(@talk)
      assert Content.talks(nil, nil, nil) == {:ok, [talk]}
    end
  end
end
