defmodule ShowNTellWeb.Schema.ContentTypes do
  @moduledoc false

  use Absinthe.Schema.Notation

  import_types Absinthe.Type.Custom

  object :user do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :first_name, non_null(:string)
    field :last_name, non_null(:string)
  end

  object :talk do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :description, non_null(:string)
    field :estimated_duration, non_null(:integer)
    field :talk_date, non_null(:date)
    field :speaker, non_null(:user)
  end
end
