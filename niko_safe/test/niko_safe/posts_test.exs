defmodule NikoSafe.PostsTest do
  use NikoSafe.DataCase

  alias NikoSafe.Posts

  describe "posts" do
    alias NikoSafe.Posts.Post

    import NikoSafe.PostsFixtures

    @invalid_attrs %{name: nil, phone_number: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Posts.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{name: "some name", phone_number: "some phone_number"}

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.name == "some name"
      assert post.phone_number == "some phone_number"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{name: "some updated name", phone_number: "some updated phone_number"}

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.name == "some updated name"
      assert post.phone_number == "some updated phone_number"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end
end
