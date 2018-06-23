defmodule ShowNTellWeb.TalksResolverTest do
  use ShowNTellWeb.ConnCase

  alias ShowNTell.Talk
  alias ShowNTellWeb.TalksResolver
  
  @talk %{
    title: "Goodness in programming",
    description: "How goodness helps programming",
    estimated_duration: 59,
    talk_date: ~D[2018-07-01]
  }

  describe "talk/3" do
    test "loads one talk by id" do
      {:ok, talk} = Talk.create_talk(@talk)
      assert TalksResolver.talk(nil, %{id: talk.id}, nil) == {:ok, talk}
    end

    test "returns nil of talk doesn't exist" do
      assert TalksResolver.talk(nil, %{id: -1}, nil) == {:ok, nil}
    end
  end

  describe "talks/3" do
    test "returns all found talks" do
      {:ok, talk} = Talk.create_talk(@talk)
      assert TalksResolver.talks(nil, nil, nil) == {:ok, [talk]}
    end
  end
end
