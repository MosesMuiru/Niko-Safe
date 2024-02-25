defmodule NikoSafe.User.Impl do
  alias NikoSafe.User.UserSchema
  alias NikoSafe.Repo

  # get all users
  #
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

end
