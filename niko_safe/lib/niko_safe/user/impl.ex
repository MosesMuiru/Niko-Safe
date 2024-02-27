defmodule NikoSafe.User.Impl do
  alias NikoSafe.User.UserSchema
  alias NikoSafe.Repo
  alias Ecto.Changeset
  # get all users
  #
  @doc"""
    create 
    
    read

    update

    delete
  """
  def get_all_users do
    Repo.all(UserSchema)
  end

  # this will return the
  def get_user_id(id) do
    Repo.get_by(UserSchema, id)
  end

  # able to insert user in the db
  #
  def insert_user(user) do
    %UserSchema{}
    |> UserSchema.changeset(user)
    |> Repo.insert() 

  end 



  @doc """
    search for that user
    enter the change you want
    then update the db

  """
  def update_user(user_id, attrs) do
    Repo.get!(UserSchema, user_id)
    |> Changeset.change(attrs)
    |> Repo.update()    
  end

  @doc """
    this is supposed to delete the user
    assume the it should take in the username of the user or the either the id

    the attrs are a struct
    delete_user(take_struct, %{id: 3})
    
    def delete_user(%UserSchema{} = user_schema) do
      epo.delete(user_schema)

    end
  """

  def delete_user(id) do
  # get the user with the id
  # delete id
  UserSchema
  |> Repo.get(id)
  |> Repo.delete()

  end

  @doc """
    change a user details based on the attrs given
    change_user(__user__struct, attrs) do
      Repo.

    end
  """
  def change_user(%UserSchema{} = user_schema, attrs \\ %{}) do
    user_schema
    |> UserSchema.changeset(attrs)
    |> Repo.update()
    

  end

    end
