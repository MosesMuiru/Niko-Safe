defmodule NikoSafe.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `NikoSafe.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        name: "some name",
        phone_number: "some phone_number"
      })
      |> NikoSafe.Posts.create_post()

    post
  end
end
