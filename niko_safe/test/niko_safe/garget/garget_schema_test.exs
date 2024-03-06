defmodule NikoSafe.Garget.GargetSchemaTest do
  use ExUnit.Case
  alias NikoSafe.Garget.GargetSchema
  alias Ecto.Changeset

  @doc """
    here i compare the types of the schema and the values

  assert 
    actual values == expected values

  ]
  """
  @optional_fields [
    {:inserted_at, :naive_datetime},
    {:updated_at, :naive_datetime},
    {:id, :id},
    {:user_id, :id}
  ]


  @optional [:id, :inserted_at, :updated_at, :user_id]
  @expected_fields [
    {:id, :id},
    {:name, :string},
    {:longitude, :string},
    {:latitude, :string},
    
    {:inserted_at, :naive_datetime},
    {:updated_at, :naive_datetime},
    {:user_id, :id}
  
  ]

  describe "fields and the types are valid" do

    test "if fields are correct with thier types" do

      actual_fields = 
        for field <- GargetSchema.__schema__(:fields) do
          type = GargetSchema.__schema__(:type, field)

          {field, type}

        end

      #check if they match
      assert MapSet.new(actual_fields) == MapSet.new(@expected_fields)
    end
  end

  @doc """
    the procedure

    create a map of valid input

    changeset = GargetSchema.changeset(%GargetSchema{}, valid_attrs}

    assert %Changeset{valid?: true, changes: changes} = changeset


    we can create a loop and pull out the field that you want and match them
    here is what i mean

    for {field, _} <- @expected_params do
        actuel = Map.get(changes, field)
        expected = valid_params

    end

    you can use mutated to remove the onchanging data like hash password

    outside for loop
    mutated == [:hash_password]
    
    then modify the loop to be

    for {field, _} <- @expected fields, field not in mutated do
  """

  describe "testing our changeset " do
    test "return valid changeset for valid attrs" do
        valid_params = %{
          "name" => "moses",
          "longitude" => "2323",
          "latitude" => "223s"}


      #insert
      changeset = GargetSchema.changeset(%GargetSchema{}, valid_params)

      assert %Changeset{valid?: true, changes: changes} = changeset

      #loop
      # you compare every value in the changeset and the valid params it it is rigght
      for {field, _} <- @expected_fields do
        # Map.get returns the value that matches with the field value

        actual = Map.get(changes, field)
        
        expected = valid_params[Atom.to_string(field)]

# assert
        
        assert actual == expected, "did not match with this firld--> #{field}\nthis is the actual--> #{inspect(actual)}\n this is the expected ->#{inspect expected}"
      end

      

    end

    # this is to test invalid inputs
    test "testing for invalid inputs" do
  
      invalid_params = %{ 
        "name" => 1212,
        "longitude" => 23,
        "latitude" => 32
      }

      assert %Changeset{ valid?: false, errors: errors} = GargetSchema.changeset(%GargetSchema{}, invalid_params)


        

      for {field, _} <- @expected_fields, field not in @optional do
        assert errors[field], "the field--> #{field} is missing from errors"

        {_, meta} = errors[field]

        assert meta[:validation] == :cast
      end
    end

    #this is for testing empty params
    test "when params are empty" do
      params = %{}

      assert %Changeset{valid?: false, errors: errors} = GargetSchema.changeset(%GargetSchema{}, params)

      for {field, _} <- @expected_fields, field not in @optional do

        assert errors[field] , "missing attrs"

        {_, meta} = errors[field]

        assert meta[:validation] == :required
  

      end
    
    end

  end
end
