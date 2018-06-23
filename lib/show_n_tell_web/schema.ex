defmodule ShowNTellWeb.Schema do
  @moduledoc """
  GraphQL schema
  """
  use Absinthe.Schema

  import_types Absinthe.Type.Custom

  alias ShowNTellWeb.TalksResolver

  object :talk do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :description, non_null(:string)
    field :estimated_duration, non_null(:integer)
    field :talk_date, non_null(:date)
  end

  query do
    field :talk, :talk do
      arg :id, non_null(:id)
      resolve &TalksResolver.talk/3
    end

    field :talks, non_null(list_of(non_null(:talk))) do
      arg :limit, :integer
      resolve &TalksResolver.talks/3
    end
  end

  mutation do
    field :create_talk, :talk do
      arg :title, non_null(:string)
      arg :description, non_null(:string)
      arg :estimated_duration, non_null(:integer)
      arg :talk_date, non_null(:date)

      resolve &TalksResolver.create_talk/3
    end
  end
end
