defmodule ShowNTell.Rest.GithubAuth do
  use Tesla

  @moduledoc """
  Use this module to exchange Github access code for Github access token.

  ## Examples

    iex> GithubAuth.access_token({"86e228e948a9e36d9d0c", "very secret state"})
    %{
      "token_type" => "bearer",
      "scope" => "read:user",
      "access_token" => "..."
    }

  """

  @access_token_path "/login/oauth/access_token"

  plug Tesla.Middleware.BaseUrl, "https://github.com"
  plug Tesla.Middleware.Headers, [{"Accept", "application/json"}]
  plug Tesla.Middleware.JSON

  def access_token(params) do
    @access_token_path
    |> post(access_token_params(params))
    |> process_token()
  end

  defp access_token_params({code, state}) do
    %{
      client_id: Application.fetch_env!(:show_n_tell, :github_client_id),
      client_secret: Application.fetch_env!(:show_n_tell, :github_client_secret),
      code: code,
      state: state
     }
  end

  defp process_token({:ok, %{body: body = %{"error" => _}}}) do
    {:fail, body}
  end

  defp process_token({:ok, %{body: body}}) do
    {:ok, body}
  end

  defp process_token({_, %{body: body}}) do
    {:fail, body}
  end
end
