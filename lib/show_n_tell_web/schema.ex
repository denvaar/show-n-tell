defmodule ShowNTellWeb.Schema do
  @moduledoc """
  GraphQL schema
  """
  use Absinthe.Schema

  import_types ShowNTellWeb.Schema.ContentTypes

  alias ShowNTellWeb.Resolvers

  query do
    field :users, non_null(list_of(non_null(:user))) do
      resolve &Resolvers.Content.users/3
    end

    @desc "Get a user by id"
    field :user, :user do
      arg :id, non_null(:id)
      resolve &Resolvers.Content.get_user/3
    end

    field :talks, non_null(list_of(non_null(:talk))) do
      resolve &Resolvers.Content.talks/3
    end

    @desc "Get a talk by id"
    field :talk, :talk do
      arg :id, non_null(:id)
      resolve &Resolvers.Content.get_talk/3
    end
  end

  @desc "Create a talk"
  mutation do
    field :create_talk, :talk do
      arg :title, non_null(:string)
      arg :description, non_null(:string)
      arg :estimated_duration, non_null(:integer)
      arg :talk_date, non_null(:date)
      resolve &Resolvers.Content.create_talk/3
    end
  end
end
