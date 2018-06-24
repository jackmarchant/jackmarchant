defmodule JackMarchantWeb.SubscribeController do
  use JackMarchantWeb, :controller

  alias Plug.Conn

  @spec subscribe(Conn.t(), map()) :: Conn.t()
  def subscribe(conn, %{"email" => email}) do
    %{email: String.downcase(email)}
    |> JackMarchant.subscribe()
    |> case do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Thank you! You have been subscribed.")
        |> redirect(to: "/")

      {:error, %{email: "already exists"}} ->
        conn
        |> put_flash(:error, "It looks like you've already subscribed...Thanks!")
        |> redirect(to: "/")

      {:error, %{email: "has invalid format"}} ->
        conn
        |> put_flash(:error, "'#{email}' isn't a valid email address. Please try again.")
        |> redirect(to: "/")
    end
  end
end
