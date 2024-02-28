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
    |> Repo.update()
    
    example the correct way of using this
  iex(32)> Impl.update_user(2,name: "waa")
[debug] QUERY OK source="user" db=0.6ms queue=0.1ms idle=1557.3ms
SELECT u0."id", u0."name", u0."phone_number", u0."inserted_at", u0."updated_at" FROM "user" AS u0 WHERE (u0."id" = $1) [2]
↳ NikoSafe.User.Impl.update_user/2, at: lib/niko_safe/user/impl.ex:43
[debug] QUERY OK source="user" db=34.9ms queue=1.3ms idle=1558.4ms
UPDATE "user" SET "name" = $1, "updated_at" = $2 WHERE "id" = $3 ["waa", ~N[2024-02-27 18:44:27], 2]
↳ anonymous fn/4 in :elixir.eval_external_handler/1, at: src/elixir.erl:309
{:ok,
 %NikoSafe.User.UserSchema{
   __meta__: #Ecto.Schema.Metadata<:loaded, "user">,
   id: 2,
   name: "waa",
   phone_number: "2024240199",
   garget: #Ecto.Association.NotLoaded<association :garget is not loaded>,
   emergency: #Ecto.Association.NotLoaded<association :emergency is not loaded>,
   rescue_team: #Ecto.Association.NotLoaded<association :rescue_team is not loaded>,
   inserted_at: ~N[2024-02-27 18:29:54],
   updated_at: ~N[2024-02-27 18:44:27]
 }}

    
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
