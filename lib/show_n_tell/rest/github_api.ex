defmodule ShowNTell.Rest.GithubApi do
  use Tesla

  @moduledoc """
  Use this module to call Github APIs.
  """

  @user_path "/user"
  @user_emails_path "/user/emails"
  @user_orgs_path "/user/orgs"

  def client(token) do
    Tesla.build_client [
      {Tesla.Middleware.BaseUrl, "https://api.github.com"},
      {Tesla.Middleware.Headers, [
        {"Accept", "application/vnd.github.v3+json"},
        {"User-Agent", "Show & Tell App"},
        {"Authorization", "token " <> token}
      ]},
      Tesla.Middleware.JSON
    ]
  end

  def user(client) do
    client
    |> get(@user_path)
  end

  def user_emails(client) do
    client
    |> get(@user_emails_path)
  end

  def user_orgs(client) do
    client
    |> get(@user_orgs_path)
  end
end
