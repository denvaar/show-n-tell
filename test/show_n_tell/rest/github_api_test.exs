defmodule ShowNTell.Rest.GithubApiTest do
  use ExUnit.Case, async: true

  import Tesla.Mock

  alias ShowNTell.Rest.GithubApi

  @client GithubApi.client("fake-token")
  @user_url "https://api.github.com/user"
  @user_emails_url "https://api.github.com/user/emails"
  @user_orgs_url "https://api.github.com/user/orgs"

  @user_body %{
    "name" => "Mr Andrew Bator"
  }

  @user_emails_body [
    %{"email" => "mr.bator@gmail.com", "primary" => false},
    %{"email" => "andrew.bator@gmail.com", "primary" => true}
  ]

  @user_orgs_body [
    %{"login" => "spacex"},
    %{"login" => "decisely"}
  ]

  setup do
    mock fn
      %{method: :get, url: @user_url} -> %Tesla.Env{status: 200, body: @user_body} 
      %{method: :get, url: @user_emails_url} -> %Tesla.Env{status: 200, body: @user_emails_body}
      %{method: :get, url: @user_orgs_url} -> %Tesla.Env{status: 200, body: @user_orgs_body}
    end

    :ok
  end

  test "loads user name from github" do
    assert {:ok, %Tesla.Env{body: @user_body}} = GithubApi.user(@client)
  end

  test "loads user emails from github" do
    assert {:ok, %Tesla.Env{body: @user_emails_body}} = GithubApi.user_emails(@client)
  end

  test "loads user orgs from github" do
    assert {:ok, %Tesla.Env{body: @user_orgs_body}} = GithubApi.user_orgs(@client)
  end
end
