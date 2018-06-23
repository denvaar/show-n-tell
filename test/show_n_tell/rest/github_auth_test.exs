defmodule ShowNTell.Rest.GithubAuthTest do
  use ExUnit.Case, async: true

  import Tesla.Mock

  alias ShowNTell.Rest.GithubAuth

  @access_token_url "https://github.com/login/oauth/access_token"

  @success_body %{
    "token_type" => "bearer",
    "scope" => "read:user",
    "access_token" => "cool-access-token"
  }

  @error_body %{
    "error" => "token was already used or something"
  }

  test "gets access token successfully" do
    mock fn %{method: :post, url: @access_token_url} -> %Tesla.Env{status: 200, body: @success_body} end
    assert {:ok, %{"access_token" => _}} = GithubAuth.access_token({"some-code", "some-secret-state"})
  end

  test "fails already used code" do
    mock fn %{method: :post, url: @access_token_url} -> %Tesla.Env{status: 200, body: @error_body} end
    assert {:fail, %{"error" => _}} = GithubAuth.access_token({"some-code", "some-secret-state"})
  end

  test "fails when github fails for whatever reason" do
    mock fn %{method: :post, url: @access_token_url} -> %Tesla.Env{status: 415, body: @error_body} end
    assert {:fail, %{"error" => _}} = GithubAuth.access_token({"some-code", "some-secret-state"})
  end
end
