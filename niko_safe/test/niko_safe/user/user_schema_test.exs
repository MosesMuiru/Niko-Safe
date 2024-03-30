defmodule NikoSafe.User.UserSchemaTest do
  alias NikoSafe.User.UserSchema
  alias Ecto.Changeset
  use ExUnit.Case

  @expected_params [
    {:id, :id},
    {:name, :string},
    {:phone_number, :string},
    {:inserted_at, :naive_datetime},
    {:updated_at, :naive_datetime}
  ]

  @optional_params [:id, :inserted_at, :updated_at]

  describe "testing for fields and types" do
    test "fields and types" do
      actual_fields =
        for field <- UserSchema.__schema__(:fields) do
          type = UserSchema.__schema__(:type, field)

          {field, type}
        end

      assert MapSet.new(actual_fields) == MapSet.new(@expected_params)
    end
  end

  describe "testing out changeset" do
    test "return valid changeset for valid attrs" do
      valid_params = %{
        "name" => "moses",
        "phone_number" => "fadfadfasd"
      }

      changeset = UserSchema.changeset(%UserSchema{}, valid_params)

      assert %Changeset{valid?: true, changes: changes} = changeset

      # compre the values in the changeset
      for {field, _} <- @expected_params do
        actual = Map.get(changes, field)

        expected = valid_params[Atom.to_string(field)]

        assert actual == expected
      end
    end

    test "test for invalid inputs" do
      invalid_params = %{
        "name" => 2323,
        "phone_number" => 24_242_424
      }

      changeset = UserSchema.changeset(%UserSchema{}, invalid_params)

      assert %Changeset{valid?: false, errors: errors} = changeset

      for {field, _} <- @expected_params, field not in @optional_params do
        assert errors[field], "the field---> #{field} is missing"

        {_, meta} = errors[field]

        assert meta[:validation] == :cast
      end
    end
  end
end
