defmodule ShowNTell.Github.Authenticator do
  @moduledoc """
  Use this module to find or create user from Github data
  """

  alias ShowNTell.Repo
  alias ShowNTell.User
  alias ShowNTell.Rest.GithubApi

  # Authenticates a user and returns the user record.
  def process_token({:ok, %{"access_token" => access_token}}) do
    client = GithubApi.client(access_token)

    client
    |> GithubApi.user_orgs()
    |> check_github_org()
    |> load_user_data(client, access_token)
    |> find_existing_user()
    |> create_new_user()
    |> render_user()
  end

  def process_token({_, body}) do
    {:fail, body}
  end

  defp check_github_org({:ok, %{status: 401} = resp}), do: {:fail, %{"error" => Map.get(resp.body, "message")}}
  defp check_github_org({:ok, orgs}) do
    github_org = Application.fetch_env!(:show_n_tell, :github_org)
    if Enum.find(orgs.body, fn org -> org["login"] == github_org end) do
      {:ok, ""}
    else
      {:fail, %{"error" => "non_member",
                "error_description" => "You are not a member of #{github_org} organization"}}
    end
  end

  defp check_github_org(_) do
    {:fail, %{"error" => "no_orgs", "error_description" => "Couldn't load the list of orgs"}}
  end

  defp load_user_data({:ok, _}, client, access_token) do
    {:ok, user} = GithubApi.user(client)
    {:ok, emails} = GithubApi.user_emails(client)

    if primary_email_record = Enum.find(emails.body, fn email -> email["primary"] end) do
      user_data = Map.merge(user.body, %{"email" => primary_email_record["email"], "access_token" => access_token})
      {:ok, user_data}
    else
      {:fail, %{"error" => "no_primary_email", "error_description" => "User doesn't have primary email"}}
    end
  end
  defp load_user_data({:fail, errors}, _, __), do: {:fail, errors}

  defp find_existing_user({:ok, user_data}), do: {:ok, user_data, Repo.get_by(User, email: user_data["email"])}
  defp find_existing_user({:fail, body}), do: {:fail, body}

  defp create_new_user({:ok, _, user}) when is_map(user), do: {:ok, user}  # User if found on the previous step.
  defp create_new_user({:ok, user_data, nil}) do                           # User is not found - need to create a new one.
    [first_name, last_name] = String.split(user_data["name"], " ")

    user = %User{}
           |> User.changeset(%{first_name: first_name,
                               last_name: last_name,
                               photo: user_data["avatar_url"],
                               email: user_data["email"],
                               github_token: user_data["access_token"]})
           |> Repo.insert!

    {:ok, user}
  end
  defp create_new_user({:fail, body}), do: {:fail, body}

  defp render_user({:ok, user}) do
    {:ok, %{email: user.email, first_name: user.first_name, last_name: user.last_name, photo: user.photo, api_token: user.github_token}}
  end
  defp render_user({:fail, body}), do: {:fail, body}
end
